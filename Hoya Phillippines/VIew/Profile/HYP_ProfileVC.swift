//
//  HYP_ProfileVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift

class HYP_ProfileVC: BaseViewController, OtpDelegate, DropdownDelegate, DateSelectedDelegate, popMessage2Delegate {
    func didTappedOKBtn(item: SuccessMessage2) {
        if item.flags == "1"{
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            if #available(iOS 13.0, *){
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            }else{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }

        }else if item.flags == "0"{
            
            let parameters : [String : Any] = [
            "ActionType": 1,
            "userid":"\(self.userId)"
        ] as [String : Any]
        print(parameters)
            self.VM.deleteAccount(parameters: parameters) { response in
                DispatchQueue.main.async {
                    print(response?.returnMessage ?? "-1")
                    if response?.returnMessage ?? "-1" == "1"{
                        DispatchQueue.main.async{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYT_SuccessMessageVC") as? HYP_SuccessMessageVC
                                vc!.delegate = self
                                vc!.successMessage = "Account deleted successfully"
                                vc!.itsComeFrom = "0"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                                }
                            }
                    }else{
                        DispatchQueue.main.async{
                            
                            }
                    }
                  self.stopLoading()
                    }
            }
        }

    }
    
    func didTappedIdCardType(item: HYP_DropDownVC) {}
    
    func acceptDate(_ vc: HYP_DatePickerVC) {
        if vc.isComeFrom == "DOB"{
            selectDOBLbl.text = vc.selectedDate
            DOB = vc.selectedDate
        }else{
            selectDateOfAnniversary.text = vc.selectedDate
            aniversaryDate = vc.selectedDate
        }
    }
    
    
    func didTappedGenderBtn(item: HYP_DropDownVC) {
        selectGenderLbl.text = item.genderName
        gender = item.genderName
    }
    
    func didTappedAccountType(item: HYP_DropDownVC) {}
    
    func didTappedRoleBtn(item: HYP_DropDownVC) {}
    
    func didTappedSalesRepresentative(item: HYP_DropDownVC) {}
    
    func didtappedNumberChanged(item: HYP_OtpVC) {
        mobileNumberTF.text = item.newNumberTF.text
    }
    

    @IBOutlet weak var idCardTyprTF: UITextField!
    @IBOutlet weak var idCardTypeView: UIView!
    @IBOutlet weak var idCardNumberView: UIView!
    @IBOutlet weak var logoutShadowView: UIView!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var deleteAccountLbl: UILabel!
    @IBOutlet weak var logoutLbl: UILabel!
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
    var aniversaryDate = ""
    var gender = ""
    var DOB = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
//        personalInformationTopHeight.constant = 20
        backBtnWidth.constant = 0 //22
        logoutView.layer.maskedCorners =  [.layerMinXMaxYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logoutView.isHidden = true
        self.logoutShadowView.isHidden = true
//        personalInformationTopHeight.constant = 20
        persionalInfoView.isHidden = true
        generalInfosView.isHidden = false
        updateBtn.isHidden = true
        personalInfoBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.30), for: .normal)
        generalInfoBtn.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1), for: .normal)
        personalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        generalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
            customerGeneralInfo()
        }
        
    }
    
    
    @IBAction func didTappedSettingBtn(_ sender: Any) {
        logoutView.isHidden ? (logoutView.isHidden =  false) : (logoutView.isHidden = true)
        logoutShadowView.isHidden ? (logoutShadowView.isHidden =  false) : (logoutShadowView.isHidden = true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.logoutShadowView{
            self.logoutShadowView.isHidden = true
            self.logoutView.isHidden = true
        }
    }
    
    @IBAction func didTappedDeleteAccount(_ sender: Any) {
        deleteAccount()
    }
    
    @IBAction func didTappedLogoutBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessMessage2") as? SuccessMessage2
        vc!.delegate = self
        vc!.message = "Are you sure you want to Logout ?"
        vc?.btnName = "Logout"
        vc?.vcTitle = "Logout"
        vc!.flags = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func didTappedUpdateBtn(_ sender: UIButton) {
        if firstNameTF.text?.count == 0{
            self.view.makeToast("Enter First Name",duration: 2.0,position: .center)
        }else if lastNameTF.text?.count == 0{
            self.view.makeToast("Enter Last Name",duration: 2.0,position: .center)
        }else if mobileNumberTF.text?.count == 0{
            self.view.makeToast("Enter mobile number",duration: 2.0,position: .center)
        }
//        else if selectDOBLbl.text == "Select DOB"{
//            self.view.makeToast("Select DOB",duration: 2.0,position: .center)
//        }
//        else if selectGenderLbl.text == "Select gender"{
//            self.view.makeToast("Select gender",duration: 2.0,position: .center)
//        }
        else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                profileUpdate_Api()
            }
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
    
    @IBAction func didEndEmailTF(_ sender: Any) {
        let email = emailTF.text ?? ""
        if email.isValidEmail{

        }else{
            emailTF.text = ""
            self.view.makeToast("Enter a Valid Email",duration: 2.0,position: .center)
            
        }
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
        generalInfoBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.30), for: .normal)
        personalInfoBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        updateBtn.isHidden = false
    }
    
    @IBAction func didTappedGeneralInfoBtn(_ sender: UIButton) {
        persionalInfoView.isHidden = true
        generalInfosView.isHidden = false
        personalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.30)
        generalInfoLineLbl.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        generalInfoBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        personalInfoBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.30), for: .normal)
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
        
//        [
//            "ActionType": "4",
//            "ActorId": userId,
//            "ObjCustomerJson": [
//                "Address1": "",
//                "CustomerId": customerTypeID,
//                "FirstName": firstNameTF.text ?? "",
//                "lastname":lastNameTF.text ?? "",
//                "Email": emailTF.text ?? "",
//                "DOB": selectDOBLbl.text ?? "",
//                "Mobile": mobileNumberTF.text ?? "",
//                "RegistrationSource": registerationNo
//            ],
//            "ObjCustomerDetails": [
//                "IsNewProfilePicture":0,
//                "Anniversary":selectDateOfAnniversary.text ?? "",
//                "Gender": selectGenderLbl.text ?? ""
//            ]
//        ]
        
        [
            "ActionType": "4",
            "ActorId": userId,
            "ObjCustomerJson": [
                "Address1": "",
                "CustomerId": customerTypeID,
                "FirstName": firstNameTF.text ?? "",
                "lastname":lastNameTF.text ?? "",
                "Email": emailTF.text ?? "",
                "DOB": DOB,
                "Mobile": mobileNumberTF.text ?? "",
                "RegistrationSource": "3",
                "rELATED_PROJECT_TYPE" : "HOYA",
                "customerTypeID": customerTypeID
            ] as [String : Any],
            "ObjCustomerDetails": [
                "IsNewProfilePicture":1,
                "Anniversary": aniversaryDate,
                "Gender": gender
            ] as [String : Any]
        ]
        print(parameter,"profile update")
        
        self.VM.peofileUpdate(parameter: parameter)
    }
    
    func deleteAccount(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessMessage2") as? SuccessMessage2
        vc!.delegate = self
        vc!.message = "Are you sure you really want to delete your account?"
        vc?.btnName = "Delete"
        vc?.vcTitle = "Delete Account"
        vc!.flags = "0"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
}
