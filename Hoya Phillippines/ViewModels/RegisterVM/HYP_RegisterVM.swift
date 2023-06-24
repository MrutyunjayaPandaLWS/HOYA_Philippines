//
//  HYP_RegisterVM.swift
//  Hoya Phillippines
//
//  Created by syed on 15/03/23.
//

import Foundation
import UIKit
import Toast_Swift


class HYP_RegisterVM{
    weak var VC: HYP_RegisterVC?
    var requestAPIs = RestAPI_Requests()
//    func languageListApi(parameter: JSON){
//        VC?.startLoading()
//        requestAPIs.language_Api(parameters: parameter) { result, error in
//            if error == nil{
//                if result != nil{
//                    DispatchQueue.main.async {
//
//                        if result?.lstAttributesDetails?.count != 0 {
//                            self.VC?.stopLoading()
//                        }else{
//                            DispatchQueue.main.async {
//                                self.VC?.stopLoading()
//                            }
//                        }
//                    }
//                }else{
//
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("Language Api error",error?.localizedDescription)
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }
//        }
//
//    }
    
    //    MARK: - CHECK MOBILE NUMBER EXISTANCY
    func checkMobileNumberExistancyApi(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.storeMobileNumberExistancy_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    if result?.returnValue == 1{
                        DispatchQueue.main.async {
                            self.VC?.view.makeToast("This mobile number already Exits", duration: 2.0, position: .center)
                            self.VC?.mobileNumberExistancy = 1
                            self.VC?.stopLoading()
                        }
                    }else{
                        self.VC?.mobileNumberExistancy = 0
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                    
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
//    MARK: - CHECK STORE-ID EXISTANCY
    func checkStoreIdExistancyApi(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.checkStoreIdExistancy_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    if result?.lstAttributesDetails?.count != 0 {
                        DispatchQueue.main.async {
                            if String(result?.lstAttributesDetails?[0].attributeValue?.prefix(2) ?? "") != "-2"{
                               // self.VC?.view.makeToast("This storeId allready exists", duration: 2.0, position: .center)
                                self.VC?.storeIdStatus = 1
                                self.VC?.locationCode = "\(result?.lstAttributesDetails?[0].attributeId ?? 0)"
                                self.VC?.storeId = "\(result?.lstAttributesDetails?[0].attributeId ?? 0)"
                                self.VC?.storeCode = "\(result?.lstAttributesDetails?[0].attributeNames ?? "")"
                                self.VC?.selectSalesLbl.text = "Select sales representative"
                                self.VC?.storeNameTF.text = result?.lstAttributesDetails?[0].attributeValue
                                self.VC?.storeNameTF.textColor = .black
                                self.VC?.checkStoreUserNameExistancy()
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.view.makeToast("Invalid Store Id", duration: 2.0, position: .center)
                                self.VC?.selectSalesLbl.text = "Select sales representative"
                                self.VC?.storeIdStatus = 0
                                self.VC?.stopLoading()
                            }
                        }
                    }else{
                        self.VC?.storeIdStatus = 0
                        self.VC?.stopLoading()
                    }

                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
    
    func checkEmailExistancyApi(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.checkEmailExistancy_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    if result?.returnValue == 1{
                        DispatchQueue.main.async {
                            self.VC?.view.makeToast("This Email allready exists", duration: 2.0, position: .center)
                            self.VC?.emailExistancy = 1
                            self.VC?.stopLoading()
                        }
                    }else{
                        self.VC?.emailExistancy = 0
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                    
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
    func checkStoreUserNameExistancy(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.checkStoreUserNameExistancy(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    if result?.returnValue == 1{
                        DispatchQueue.main.async {
                            self.VC?.storeUserNameExistancy = 1
                            self.VC?.stopLoading()
                        }
                    }else{ 
                        DispatchQueue.main.async {
                            self.VC?.view.makeToast("Store User Name already register used different store id", duration: 2.0, position: .center)
                            self.VC?.storeUserNameExistancy = 0
                            self.VC?.stopLoading()
                        }
                        
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                    
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    //   MARK: - chechIdNumberExistancyApi
        func checkIdcardExistancy(parameter : JSON){
            print(parameter)
            self.VC?.startLoading()
            requestAPIs.chechIdNumberExistancyApi(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        print(result?.lstAttributesDetails?[0].attributeId,"id existancy")
                        result?.lstAttributesDetails?[0].attributeId
                        if result?.lstAttributesDetails?[0].attributeId == 0{
                            DispatchQueue.main.async {
                                
                                self.VC?.idCardValidationStatus = 1
                                self.VC?.stopLoading()
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.VC?.idCardValidationStatus = 2
                                self.VC?.view.makeToast("Id Number already exist !", duration: 2.0, position: .center)
                                self.VC?.idCardNumberTF.text = ""
                                self.VC?.stopLoading()
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    
    func checkIdcardValidation(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.checkIdcardNumberValidation(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    if result?.lstAttributesDetails?[0].attributeId == 1{
                        DispatchQueue.main.async {
                            
                            self.VC?.idCardValidationStatus = 1
                            self.VC?.stopLoading()
                            self.VC?.checkIDcardExiistancy()
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.VC?.idCardValidationStatus = 2
                            self.VC?.view.makeToast("Enter a valid IdCard Number", duration: 2.0, position: .center)
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
    
    
    //    MARK: - REGISTRATION API
    func registrationApi(parameter: JSON){
            self.VC?.startLoading()
            requestAPIs.registrationApi(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            if String(result?.returnMessage?.prefix(1) ?? "") == "1"{
                                self.VC?.successMessagePopUp(message: "You have registered successfully")
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.view.makeToast("registration Failed", duration: 2.0, position: .center)
                                self.VC?.stopLoading()
                            }
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
}
