//
//  HYP_LoginVC.swift
//  Hoya Phillippines
//
//  Created by syed on 16/02/23.
//

import UIKit
import DPOTPView
import Toast_Swift

class HYP_LoginVC: BaseViewController {

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
    var VM = HYP_HYP_LoginVM()
    var otpBtnStatus = 0
    var mobileNumberExistancy = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.VM.tokendata()
    }
    
    @IBAction func selectMembersIDTF(_ sender: UITextField) {
        mobileNumberExistancyApi()
    }
    
    @IBAction func didTappedResendBtn(_ sender: UIButton) {
        sendOtptoRegisterNumber()
    }
    
    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        if otpBtnStatus == 0{
            if membershipIDTF.text?.count == 0{
                self.view.makeToast("Enter membershipId/mobile number",duration: 2.0,position: .center)
            }else if mobileNumberExistancy == -1{
                self.view.makeToast("Enter a valid mobile Number",duration: 2.0,position: .center)
            }else{
                otpView.isUserInteractionEnabled = true
                otpBtnStatus = 1
                SubmitBtn.setTitle("Submit", for: .normal)
                sendOtptoRegisterNumber()
            }
        }else{
            if otpView.text?.count == 0{
                self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
            }else{
                if otpView.text != "123456"{
                    self.view.makeToast("Enter wrong OTP",duration: 2.0,position: .center)
                }else{
                    
                    loginSubmissionApi()
//                    if #available(iOS 13.0, *) {
//                        let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
//                        sceneDelegate.setHomeAsRootViewController()
//                    } else {
//                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        appDelegate.setHomeAsRootViewController()
//                    }
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
    
    func mobileNumberExistancyApi(){
        let parameter : [String : Any] = [
                "ActionType": "57",
                "Location": [
                    "UserName" : "\(membershipIDTF.text ?? "")"
                ]
        ]
        VM.verifyMobileNumberAPI(paramters: parameter)
//        56875434356
    }
    
    func sendOtptoRegisterNumber(){
        let parameter : [String : Any] = [
            
                "MerchantUserName": "MSPDemoAdmin",
                "MobileNo": membershipIDTF.text ?? "",
                "OTPType": "Enrollment",
                "UserId": -1,
                "UserName": ""
            
        ]
        self.VM.getOtpApi(parameter: parameter)
    }
    
    func loginSubmissionApi(){
        let parameter : [String : Any] = [
            
                "Browser": "Android",
                "LoggedDeviceName": "Android",
                "Password": "123456",
                "PushID":"",
                "SessionId": "HOYA",
                "UserActionType": "GetPasswordDetails",
                "UserName": membershipIDTF.text ?? "",
                "UserType": "Customer"
            
        ]
        VM.loginSubmissionApi(parameter: parameter)
    }
    
}
