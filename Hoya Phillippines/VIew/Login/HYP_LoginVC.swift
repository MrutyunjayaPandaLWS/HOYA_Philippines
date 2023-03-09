//
//  HYP_LoginVC.swift
//  Hoya Phillippines
//
//  Created by syed on 16/02/23.
//

import UIKit
import DPOTPView
import Toast_Swift

class HYP_LoginVC: UIViewController {

    @IBOutlet weak var timmerLbl: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var loginInfoLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var registerDescLbl2: UILabel!
    @IBOutlet weak var registrationDescLbl: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var membershipIDTF: UITextField!
    
    var timmer = Timer()
    var count = 0
    var otpBtnStatus = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.clipsToBounds = true

        loginView.clipsToBounds = true
        loginView.layer.cornerRadius = 30
        loginView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        timmerLbl.isHidden = true
        resendBtn.isHidden = true
        SubmitBtn.setTitle("Get OTP", for: .normal)
        otpView.isUserInteractionEnabled = false
    }
    
    @IBAction func didTappedResendBtn(_ sender: UIButton) {
        self.timmer.invalidate()
        self.count = 60
        self.timmer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        if otpBtnStatus == 0{
            if membershipIDTF.text?.count == 0{
                self.view.makeToast("Enter membershipId/mobile number",duration: 2.0,position: .center)
            }else{
                otpView.isUserInteractionEnabled = true
                otpBtnStatus = 1
                SubmitBtn.setTitle("Submit", for: .normal)
                self.timmer.invalidate()
                self.count = 60
                timmerLbl.isHidden = false
                self.timmer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
        }else{
            if otpView.text?.count == 0{
                self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
            }else{
                if otpView.text != "123456"{
                    self.view.makeToast("Enter wrong OTP",duration: 2.0,position: .center)
                }else{
                    if #available(iOS 13.0, *) {
                        let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                        sceneDelegate.setHomeAsRootViewController()
                    } else {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setHomeAsRootViewController()
                    }
                    UserDefaults.standard.set(true, forKey: "UserLoginStatus")
                }
            }
        }
    }
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTappedRegisterBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_RegisterVC") as? HYP_RegisterVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedHelpBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_HelpVC") as? HYP_HelpVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func update() {
        if(self.count > 1) {
            self.count = Int(self.count) - 1
            timmerLbl.text = "00:\(self.count)"
            timmerLbl.isHidden = false
            resendBtn.isHidden = true
           
        }else{
            self.timmer.invalidate()
//            sendotp = 0
            timmerLbl.text = "00:00"
            timmerLbl.isHidden = true
          resendBtn.isHidden = false
        }
    }
}
