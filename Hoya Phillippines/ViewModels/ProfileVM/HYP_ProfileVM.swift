//
//  HYP_ProfileVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation


class HYP_ProfileVM{
    
    weak var VC : HYP_ProfileVC?
    var requestAPIs = RestAPI_Requests()
    var generalInfo = [LstCustomerJson]()
    func customerGeneralInfo(parameter: JSON){
        self.generalInfo.removeAll()
        self.VC?.startLoading()
        requestAPIs.getGeneralInfo(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.generalInfo = result?.lstCustomerJson ?? []
                    DispatchQueue.main.async {
                        if result?.lstCustomerJson?.count != 0{
                            self.VC?.membershipId.text = self.generalInfo[0].loyaltyId ?? ""
                            self.VC?.roleLbl.text = self.generalInfo[0].customerType ?? ""
                            self.VC?.storeIDLbl.text = self.generalInfo[0].locationCode ?? ""
                            self.VC?.storeNameLbl.text = self.generalInfo[0].locationName ?? "-"
                            self.VC?.salesRepresentativeTF.text = self.generalInfo[0].user ?? ""
                            self.VC?.firstNameTF.text = self.generalInfo[0].firstName ?? ""
                            self.VC?.lastNameTF.text = self.generalInfo[0].lastName ?? ""
                            self.VC?.mobileNumberTF.text = self.generalInfo[0].mobile ?? ""
                            self.VC?.emailTF.text = self.generalInfo[0].email ?? ""
                            if self.generalInfo[0].gender?.count == 0 || self.generalInfo[0].gender == nil{
                                self.VC?.selectGenderLbl.text = "Select gender"
                            }else{
                                self.VC?.selectGenderLbl.text = self.generalInfo[0].gender ?? "-"
                            }
                            if (self.generalInfo[0].customerTypeID ?? 0) == 1{
                                self.VC?.idCardNumberView.isHidden = true
                                self.VC?.idCardTypeView.isHidden = true
                            }else{
                                self.VC?.idCardNumberView.isHidden = false
                                self.VC?.idCardTypeView.isHidden = false
                                let idCardType = self.generalInfo[0].lIdentificationType ?? 0
                                if( idCardType == 1){
                                    self.VC?.idCardTyprTF.text = "Passport"
                                }else if(idCardType == 7){
                                    self.VC?.idCardTyprTF.text = "SSS ID"
                                }else if(idCardType == 8){
                                    self.VC?.idCardTyprTF.text = "PRC ID"
                                }else if(idCardType == 9){
                                    self.VC?.idCardTyprTF.text = "Driving License"
                                }else{
                                    self.VC?.idCardTyprTF.text = "-"
                                }
                            }
                            self.VC?.gender = self.generalInfo[0].gender ?? ""
                            let DOB = self.generalInfo[0].jdob?.split(separator: " ")
                            self.VC?.selectDOBLbl.text = String(DOB?[0] ?? "Select DOB")
                            let DOA = self.generalInfo[0].anniversary?.split(separator: " ")
                            self.VC?.selectDateOfAnniversary.text = String(DOA?[0] ?? "Select Date")
                            self.VC?.registerationNo = self.generalInfo[0].registrationSource ?? 0
                            self.VC?.idCardNumberTF.text = self.generalInfo[0].identificationNo ?? "-"
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.stopLoading()
                        }
//                        if result?.lstCustomerIdentityInfo?.count != 0{
//                            self.VC?.idCardNumberTF.text = result?.lstCustomerIdentityInfo?[0]
//                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("My profile error",error?.localizedDescription)
                }
            }
        }
    }
    
    
    
    func peofileUpdate(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.profileUpdate(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if ((result?.returnMessage?.contains("1")) != nil){
                            self.VC?.profileUpDateMessageP(message: "Your profile has been updated successfully")
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.view.makeToast("Profile isn't Update", duration: 2.0, position: .center)
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("My profile Update error",error?.localizedDescription)
                }
            }
        }
    }
    
    
    func deleteAccount(parameters: JSON, completion: @escaping (DeleteAccountModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.deleteAccountApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
  
}
