//
//  HYP_RegisterVC.swift
//  Hoya Phillippines
//
//  Created by syed on 16/02/23.
//

import UIKit
import Toast_Swift


class HYP_RegisterVC: BaseViewController, DropdownDelegate, DateSelectedDelegate ,UITextFieldDelegate {
    func didTappedIdCardType(item: HYP_DropDownVC) {
        selectIDCardTypeLbl.text = item.genderName
        idCardNumberTF.text = ""
    }
    
    func acceptDate(_ vc: HYP_DatePickerVC) {
        if vc.isComeFrom == "DOB"{
            selectDOBLbl.text = vc.selectedDate
        }else{}
    }
    
    func didTappedGenderBtn(item: HYP_DropDownVC) {
        selectGenderLbl.text = item.genderName
    }
    
    func didTappedAccountType(item: HYP_DropDownVC) {
        selectUserTypeLbl.text = item.accountType
        if item.accountType == "Individual"{
            self.storeIdTF.text = ""
            self.storeNameTF.text = ""
            self.selectRoleLbl.text = "Select role"
            self.firstNameTF.text = ""
            self.lastNameTF.text = ""
            self.emailTF.text = ""
            self.mobileNumberTf.text = ""
            self.selectSalesLbl.text = "Select sales representative"
            self.selectDOBLbl.text = "Select DOB"
            self.selectGenderLbl.text = "Select gender"
            self.idCardNumberTF.text = ""
            self.selectIDCardTypeLbl.text = "Select ID type"
        }
        
    }
    
    func didTappedRoleBtn(item: HYP_DropDownVC) {
        selectRoleLbl.text = item.roleName
        
    }
    
    func didTappedSalesRepresentative(item: HYP_DropDownVC) {
        selectSalesLbl.text = item.salesRepresentativeName
        
    }
    

    @IBOutlet weak var selectIDCardTypeLbl: UILabel!
    @IBOutlet weak var firstNameTopConstaints: NSLayoutConstraint!
    @IBOutlet weak var selectRoleView: UIView!
    @IBOutlet weak var roleStarImage: UILabel!
    @IBOutlet weak var SelectDOBView: UIView!
    @IBOutlet weak var selectGenderView: UIView!
    @IBOutlet weak var backLBl: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var idCardNumberTF: UITextField!
    @IBOutlet weak var idcardNumberLbl: UILabel!
    @IBOutlet weak var selectGenderLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var selectDOBLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var selectSalesLbl: UILabel!
    @IBOutlet weak var salesRepresentativeLbl: UILabel!
    @IBOutlet weak var mobileNumberTf: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var selectRoleLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var storeNameTF: UITextField!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var storeIdTF: UITextField!
    @IBOutlet weak var storeidLbl: UILabel!
    
    @IBOutlet weak var selectUserTypeTitleLbl: UILabel!
    @IBOutlet weak var selectUserTypeLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerInfoLbl: UILabel!
    @IBOutlet weak var registerLbl: UILabel!
    var validationMobileNo = 1
    var emailValidStatus = 1
    var storeIdStatus = 1
    var idCardStatus = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        registerView.layer.cornerRadius = 30
        registerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        registerView.clipsToBounds = true

        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        mobileNumberTf.delegate = self
    }
    
    @IBAction func didTappedSelectUserTypeBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        vc?.flags = "accountType"
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedGenderBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        vc?.flags = "gender"
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedDOBBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DatePickerVC") as? HYP_DatePickerVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        vc?.isComeFrom = "DOB"
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedSalesRepresesntativeBtn(_ sender: UIButton) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select Account Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else if storeNameTF.text?.count == 0 {
            self.view.makeToast("", duration: 2.0, position: .center)
        }else if selectRoleLbl.text == "Select role"{
            self.view.makeToast("Select the Role", duration: 2.0, position: .center)
        }else if firstNameTF.text?.count == 0 {
            self.view.makeToast("Enter the first name", duration: 2.0, position: .center)
        }else if lastNameTF.text?.count == 0 {
            self.view.makeToast("Enter the last name", duration: 2.0, position: .center)
        }else if mobileNumberTf.text?.count == 0 {
            self.view.makeToast("Enter your mobile number", duration: 2.0, position: .center)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            vc?.delegate = self
            vc?.flags = "sales"
            present(vc!, animated: true)
        }
    }
    
    @IBAction func didTappedRegisterBtn(_ sender: UIButton) {
        if selectUserTypeLbl.text == "Select user type"{
            self.view.makeToast("Select user type",duration: 2.0,position: .center)
        }else if storeIdTF.text?.count == 0{
            self.view.makeToast("Enter store id",duration: 2.0,position: .center)
        }else if selectRoleLbl.text == "Select role"{
            self.view.makeToast("Select role",duration: 2.0,position: .center)
        }else if firstNameTF.text?.count == 0{
            self.view.makeToast("Enter first name",duration: 2.0,position: .center)
        }else if lastNameTF.text?.count == 0{
            self.view.makeToast("Enter last name",duration: 2.0,position: .center)
        }else if mobileNumberTf.text?.count == 0{
            self.view.makeToast("Enter mobile number",duration: 2.0,position: .center)
        }else if selectSalesLbl.text == "Select sales representative"{
            self.view.makeToast("Select sales representative",duration: 2.0,position: .center)
        }else if selectIDCardTypeLbl.text == "Select ID type"{
            self.view.makeToast("Select ID type",duration: 2.0,position: .center)
        }else if idCardNumberTF.text?.count == 0{
            self.view.makeToast("Enter Id card number",duration: 2.0,position: .center)
        }else if storeIdStatus == 0{
            self.view.makeToast("The store id is invalid",duration: 2.0,position: .center)
        }else if emailValidStatus == 0 && emailTF.text?.count != 0{
            self.view.makeToast("Enter a valid email",duration: 2.0,position: .center)
        }else if validationMobileNo == 0{
            self.view.makeToast("Enter a valid mobile number",duration: 2.0,position: .center)
        }else if idCardStatus == 0{
            self.view.makeToast("Enter a valid ID card number",duration: 2.0,position: .center)
        } else{
            successMessagePopUp(message: "You have registered successfully")
        }
    }
    
    @IBAction func didTappedSelectRoleBtn(_ sender: UIButton) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select user Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            vc?.delegate = self
            vc?.flags = "role"
            present(vc!, animated: true)
        }
    }
    
    @IBAction func selectStoreIdTF(_ sender: UITextField) {
        if selectUserTypeLbl.text != "Select user type"{
            if storeIdTF.text?.count != 0{
                
            }else{
                self.storeNameTF.text = ""
                self.selectRoleLbl.text = "Select role"
                self.firstNameTF.text = ""
                self.lastNameTF.text = ""
                self.emailTF.text = ""
                self.mobileNumberTf.text = ""
                self.selectSalesLbl.text = "Select sales representative"
                self.selectIDCardTypeLbl.text = "Select ID type"
                self.selectDOBLbl.text = "Select DOB"
                self.selectGenderLbl.text = "Select gender"
                self.idCardNumberTF.text = ""
            }
        }else{
            self.view.makeToast("Select the user type",duration: 2,position: .center)
        }
        
    }
    
    @IBAction func didTappedFirstName(_ sender: Any) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select user Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else if storeNameTF.text?.count == 0 {
            self.view.makeToast("", duration: 2.0, position: .center)
        }else if firstNameTF.text?.count == 0 {
            self.view.makeToast("Enter the first name", duration: 2.0, position: .center)
        }
    }
    
    @IBAction func didTappedlastName(_ sender: Any) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select user Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else if storeNameTF.text?.count == 0 {
            self.view.makeToast("", duration: 2.0, position: .center)
        }else if firstNameTF.text?.count == 0 {
            self.view.makeToast("Enter the first name", duration: 2.0, position: .center)
        }else if lastNameTF.text?.count == 0 {
            self.view.makeToast("Enter the last name", duration: 2.0, position: .center)
        }
    }
    
    
    @IBAction func selectEmailTF(_ sender: UITextField) {
        if emailTF.text?.count != 0{
            if (emailTF.text?.isValidEmail == true){
                
            }else{
                view.makeToast("Enter a valid email", duration: 2.0, position: .center)
            }
        }
    }
    
    @IBAction func selectMobileNumberTF(_ sender: UITextField) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select user Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else if storeNameTF.text?.count == 0 {
            self.view.makeToast("", duration: 2.0, position: .center)
        }else if selectRoleLbl.text == "Select role"{
            self.view.makeToast("Select the Role", duration: 2.0, position: .center)
        }else if firstNameTF.text?.count == 0 {
            self.view.makeToast("Enter the first name", duration: 2.0, position: .center)
        }else if lastNameTF.text?.count == 0 {
            self.view.makeToast("Enter the last name", duration: 2.0, position: .center)
        }else if mobileNumberTf.text?.count == 0{
            validationMobileNo = 0
        }else  if mobileNumberTf.text?.count != 10{
            self.view.makeToast("Mobile number should be 9 digit", duration: 2.0, position: .center)
            validationMobileNo = 0
        }else{
            validationMobileNo = 1
        }
        
    }
    
    @IBAction func selectIdCardNumberTF(_ sender: UITextField) {
        
        if selectUserTypeLbl.text == "Select user type"{
            self.view.makeToast("Select user type",duration: 2.0,position: .center)
        }else if storeIdTF.text?.count == 0{
            self.view.makeToast("Enter store id",duration: 2.0,position: .center)
        }else if selectRoleLbl.text == "Select role"{
            self.view.makeToast("Select role",duration: 2.0,position: .center)
        }else if firstNameTF.text?.count == 0{
            self.view.makeToast("Enter first name",duration: 2.0,position: .center)
        }else if lastNameTF.text?.count == 0{
            self.view.makeToast("Enter last name",duration: 2.0,position: .center)
        }else if mobileNumberTf.text?.count == 0{
            self.view.makeToast("Enter mobile number",duration: 2.0,position: .center)
        }else if selectSalesLbl.text == "Select sales representative"{
            self.view.makeToast("Select sales representative",duration: 2.0,position: .center)
        }else if selectIDCardTypeLbl.text == "Select ID type"{
            self.view.makeToast("Select ID type",duration: 2.0,position: .center)
        }else{
            
        }
    }
    
    @IBAction func selectIDCardType(_ sender: UIButton) {
        if selectUserTypeLbl.text == "Select user type" {
            self.view.makeToast("Select user Type", duration: 2.0, position: .center)
        }else if storeIdTF.text?.count == 0 {
            self.view.makeToast("Enter the store ID", duration: 2.0, position: .center)
        }else if storeNameTF.text?.count == 0 {
            self.view.makeToast("", duration: 2.0, position: .center)
        }else if selectRoleLbl.text == "Select role"{
            self.view.makeToast("Select the Role", duration: 2.0, position: .center)
        }else if firstNameTF.text?.count == 0 {
            self.view.makeToast("Enter the first name", duration: 2.0, position: .center)
        }else if lastNameTF.text?.count == 0 {
            self.view.makeToast("Enter the last name", duration: 2.0, position: .center)
        }else if mobileNumberTf.text?.count == 0 {
            self.view.makeToast("Enter your mobile number", duration: 2.0, position: .center)
        }else if selectSalesLbl.text == "Select sales representative"{
            self.view.makeToast("Select sales representative", duration: 2.0, position: .center)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            vc?.delegate = self
            vc?.flags = "idType"
            present(vc!, animated: true)
        }
        
        
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength : Int = 10
        if textField == mobileNumberTf{
            maxLength = 10
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
