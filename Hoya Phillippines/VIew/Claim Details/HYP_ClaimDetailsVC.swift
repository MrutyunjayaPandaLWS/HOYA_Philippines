//
//  HYP_ClaimDetailsVC.swift
//  Hoya Phillippines
//
//  Created by syed on 20/02/23.
//

import UIKit
import Toast_Swift
import AVFoundation
import Lottie

class HYP_ClaimDetailsVC: BaseViewController, FilterStatusDelegate, UITextFieldDelegate, SearchableDropDownDelegate {
    func didTappedFilterStatus(item: HYP_DropDownVC) {
//        productNameLbl.text = item.statusName
        productNameLbl.text = item.statusName
        productNameLbl.textColor = .black
        productName = item.statusName
        productCode = "\(item.statusId)"
    }
    
    func selectedProductName(item: SelectDealerDropDownVC) {
        productNameLbl.text = item.selectedStatusName
        productNameLbl.textColor = .black
        productName = item.selectedStatusName
        productCode = "\(item.selectedStatusID)"
    }


    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var invoiceNumberTF: UITextField!
    @IBOutlet weak var validDate: UILabel!
    
    @IBOutlet weak var programName: UILabel!
    var VM = ClaimDetailsVM()
    var promotionData : LtyPrgBaseDetails?
    var isscannedOnce = false
    var qrList = [String]()
    var invoiceNumber = ""
    var quantity = "1"
    var scanCodeStatus = -1
    var productCodeStatus = -1
    var salesReturnStatus = -1
    var productName = ""
    var productCode = ""
    var productAndInvoiceValidation = "false"
    var flags = ""
    var timmer = Timer()
    var placeHolderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invoiceNumberTF.delegate = self
        programName.text = promotionData?.programName ?? "-"
        validDate.text = "Validity until: \(promotionData?.jEndDate?.prefix(10) ?? "-")"
        quantityTF.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        if invoiceNumberTF.text?.count == 0{
            self.view.makeToast("Enter invoice number", duration: 2.0, position: .center)
        }else if productNameLbl.text == "Select Lens Design"{
            self.view.makeToast("Select Product Name", duration: 2.0, position: .center)
        }else if quantityTF.text?.count == 0{
            self.view.makeToast("Enter Product Name", duration: 2.0, position: .center)
        }else{
            productValidationApi(productId: productCode)
        }
        
    }
    @IBAction func didTappedCancelBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedSelectProductNameBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectDealerDropDownVC") as? SelectDealerDropDownVC
            vc?.modalPresentationStyle = .overFullScreen
            vc?.modalTransitionStyle = .crossDissolve
    //            vc?.flags = "productList"
            vc?.progrmaId = promotionData?.programId ?? 0
            vc?.delegate = self
            present(vc!, animated: true)
        }
    }
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //    MARK: - LWS - INVOICE NUMBER VALIDATION API
        func invoiceNumberCheckApi(invoiceNumber: String){
            let parameter : [String : Any] = [
                    "ActionType": 168,
                    "RoleIDs": invoiceNumber
            ]
            print(parameter,"invoiceNumberCheckApi")
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                self.VM.invoiceNumberValidationApi(parameter: parameter)
            }
            
        }
        
    
    
    //    MARK: LWS - PRODUCT VALIDATION API
        func productValidationApi(productId: String){
            
            let parameter : [String : Any] = [
            
                    "ActionType": 169,
                    "RoleIDs": "\(productId)" ,   // SEND PRODUCT CODE IN THIS TAGS
                    "HelpTopicID": promotionData?.programId ?? 0// SEND LOYALTY PROGRAM ID HERE
            ]
            print(parameter,"productValidationApi")
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                self.VM.productValidationApi(parameter: parameter)
            }
            
        }
    
    //    MARK: - COMBINATION VALIDATION API
        func combineValidationApi(){
            let parameter : [String : Any] = [
                
                    "ActionType": 170,
                    "RoleIDs": invoiceNumberTF.text ?? "",  // SEND INVOIVE NUMBER HERE
                    "MobilePrefix": productCode // SEND PRODUCTNAME HERE
                 
            ]
            print(parameter,"combineValidationApi")
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                self.VM.combine_Inv_Pro_Validation(parameter: parameter)
            }
            
        }
        
    //    MARK: - CLAIM SUBMISSION API
        func claimSubmission_Api(){
            let parameter : [String : Any] = [
                "ActorId": userId,
                "LoyaltyId": loyaltyId,
                "InvoiceNumber": invoiceNumberTF.text ?? "",
                "ProductCode": productNameLbl.text ?? "",
                "SellingPrice": 1,
                "LoyaltyProgramId": promotionData?.programId ?? 0,
                "VoucherImagePath": "",
                "Domain": "Hoya",
                "ClaimingQuantity": quantityTF.text ?? "0"
            ]
            print(parameter,"claimSubmission_Api")
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                self.VM.claimSubmissionApi(parameter: parameter)
            }
            
        }
        
    //    MARK: - HOYA VALIDATION
        func hoyaValidationApi(){
            let parameter : [String : Any] = [
                "Country": "Thailand",
                "InvoiceNo":invoiceNumberTF.text ?? "",
                "LenDesign": productNameLbl.text ?? "",
                "Quantity": quantityTF.text ?? ""
            ]
            print(parameter,"hoyaValidationApi")
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                self.VM.hoyaValidationApi(paramters: parameter)
            }
            
        }
        
    //    MARK: - PRODUCT LISTING API
        func getProductList_Api(){
            let parameter : [String : Any] = [
                    "ActorId":userId,
                     "SearchText": "",
                    "LoyaltyProgramId": promotionData?.programId ?? 0,
                    "ProductDetails":[
                        "ActionType": 20
                    ]
            ]
            print(parameter,"getProductList_Api")
            
            self.VM.productListApi(parameter: parameter)
        }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.invoiceNumberTF.text = self.invoiceNumberTF.text?.uppercased()
        return true
    }
    
}
