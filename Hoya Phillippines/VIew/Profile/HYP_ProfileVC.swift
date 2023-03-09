//
//  HYP_ProfileVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift

class HYP_ProfileVC: UIViewController, OtpDelegate, DropdownDelegate, DateSelectedDelegate {
    func didTappedIdCardType(item: HYP_DropDownVC) {}
    
    func acceptDate(_ vc: HYP_DatePickerVC) {
        if vc.isComeFrom == "DOB"{
            selectDOBLbl.text = vc.selectedDate
        }else{
            
        }
    }
    
    
    func didTappedGenderBtn(item: HYP_DropDownVC) {
        selectGenderLbl.text = item.genderName
    }
    
    func didTappedAccountType(item: HYP_DropDownVC) {}
    
    func didTappedRoleBtn(item: HYP_DropDownVC) {}
    
    func didTappedSalesRepresentative(item: HYP_DropDownVC) {}
    
    func didtappedNumberChanged(item: HYP_OtpVC) {
        mobileNumberTF.text = item.newNumberTF.text
    }
    
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var personalInfoLineLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var persionalInfoView: UIView!
    @IBOutlet weak var generalInfosView: UIView!
    @IBOutlet weak var selectGenderLbl: UILabel!
    @IBOutlet weak var selectDOBLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var salesRepresentativeTF: UITextField!
    @IBOutlet weak var idCardNumberTF: UITextField!
    @IBOutlet weak var storeNameLbl: UITextField!
    @IBOutlet weak var storeIDLbl: UITextField!
    @IBOutlet weak var roleLbl: UITextField!
    @IBOutlet weak var membershipId: UITextField!
    @IBOutlet weak var personalInfoBtn: UIButton!
    @IBOutlet weak var generalInfoLineLbl: UILabel!
    @IBOutlet weak var generalInfoBtn: UIButton!
    @IBOutlet weak var personalInformationTopHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        personalInformationTopHeight.constant = 20
        backBtnWidth.constant = 0 //22
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        personalInformationTopHeight.constant = 20
        persionalInfoView.isHidden = true
        generalInfosView.isHidden = false
        updateBtn.isHidden = true
        personalInfoBtn.titleLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.30)
        generalInfoBtn.titleLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        personalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        generalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    @IBAction func didTappedUpdateBtn(_ sender: UIButton) {
        if firstNameTF.text?.count == 0{
            
        }else if lastNameTF.text?.count == 0{
            
        }else if mobileNumberTF.text?.count == 0{
            
        }else if selectDOBLbl.text == "Select DOB"{
            
        }else if selectGenderLbl.text == "Select gender"{
            
        }else{
            profileUpDateMessageP(message: "Your profile has been updated successfully")
        }
       
    }
    
    @IBAction func didTappedGenderBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = "gender"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedSelectDOBBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DatePickerVC") as? HYP_DatePickerVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.isComeFrom = "DOB"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedMobileNumberEditBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_OtpVC") as? HYP_OtpVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedPersionalBtn(_ sender: UIButton) {
        
        persionalInfoView.isHidden = false
        generalInfosView.isHidden = true
        personalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        generalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        generalInfoBtn.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        personalInfoBtn.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        updateBtn.isHidden = false
    }
    
    @IBAction func didTappedGeneralInfoBtn(_ sender: UIButton) {
        persionalInfoView.isHidden = true
        generalInfosView.isHidden = false
        personalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        generalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        generalInfoBtn.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        personalInfoBtn.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        updateBtn.isHidden = true
    }
    
    func profileUpDateMessageP(message: String){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.successMessage = message
        present(vc!, animated: true)
    }
}
