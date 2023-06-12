//
//  HYP_ProfileVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift

class HYP_ProfileVC: BaseViewController, OtpDelegate, DropdownDelegate, DateSelectedDelegate {
    func didTappedIdCardType(item: HYP_DropDownVC) {}
    
    func acceptDate(_ vc: HYP_DatePickerVC) {
        if vc.isComeFrom == "DOB"{
            selectDOBLbl.text = vc.selectedDate
        }else{
            selectDateOfAnniversary.text = vc.selectedDate
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
    

    @IBOutlet weak var selectDateOfAnniversary: UILabel!
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
    var VM = HYP_ProfileVM()
    var registerationNo : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        personalInformationTopHeight.constant = 20
        backBtnWidth.constant = 0 //22
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customerGeneralInfo()

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
            self.view.makeToast("Enter First Name",duration: 2.0,position: .center)
        }else if lastNameTF.text?.count == 0{
            self.view.makeToast("Enter Last Name",duration: 2.0,position: .center)
        }else if mobileNumberTF.text?.count == 0{
            self.view.makeToast("Enter mobile number",duration: 2.0,position: .center)
        }else if selectDOBLbl.text == "Select DOB"{
            self.view.makeToast("Select DOB",duration: 2.0,position: .center)
        }else if selectGenderLbl.text == "Select gender"{
            self.view.makeToast("Select gender",duration: 2.0,position: .center)
        }else{
            profileUpdate_Api()
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
    
    @IBAction func selectDateOfAnivesary(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DatePickerVC") as? HYP_DatePickerVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.isComeFrom = "1"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    func profileUpDateMessageP(message: String){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.successMessage = message
        present(vc!, animated: true)
    }
    
    func customerGeneralInfo(){
        let parameter : [String : Any] = [
            
               "ActionType": "6",
               "CustomerId": "\(self.userId)"//customerTypeID
        ]
        
        self.VM.customerGeneralInfo(parameter: parameter)
    }
    
//    MARK: - PROFILE UPDATE API
    func profileUpdate_Api(){
        let parameter : [String : Any] =
        
        [
            "ActionType": "4",
            "ActorId": userId,
            "ObjCustomerJson": [
                "Address1": "",
                "CustomerId": customerTypeID,
                "FirstName": firstNameTF.text ?? "",
                "lastname":lastNameTF.text ?? "",
                "Email": emailTF.text ?? "",
                "DOB": selectDOBLbl.text ?? "",
                "Mobile": mobileNumberTF.text ?? "",
                "RegistrationSource": registerationNo
            ],
            "ObjCustomerDetails": [
                "IsNewProfilePicture":0,
                "Anniversary":selectDateOfAnniversary.text ?? "",
                "Gender": selectGenderLbl.text ?? ""
            ]
        ]
        
        self.VM.peofileUpdate(parameter: parameter)
    }
}
