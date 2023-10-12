//
//  ClaimDetailsVM.swift
//  Hoya Phillippines
//
//  Created by admin on 20/06/23.
//

import Foundation
class ClaimDetailsVM: SuccessMessageDelegate{
    func successMessage() {
        self.VC?.navigationController?.popToRootViewController(animated: true)
    }
    
    weak var VC: HYP_ClaimDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    var promotionProductList = [LsrProductDetails]()
    
    
    //    MARK: - invoice Number Validation API
    func invoiceNumberValidationApi(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.invoiceNumberValidation_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print("invoice",result?.lstAttributesDetails?[0].attributeId)
                        if result?.lstAttributesDetails?[0].attributeId == 0{
                            self.VC?.scanCodeStatus = 1
                            self.VC?.stopLoading()
                            self.VC?.combineValidationApi()
                        }else{

                            self.VC?.stopLoading()
                            self.VC?.hoyaValidationApi()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print("No data found")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("invoice number error",error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    //    MARK: - Product Validation API
    func productValidationApi(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.productNumberValidation_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    print("product",result?.lstAttributesDetails?[0].attributeId ?? 0)
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?[0].attributeId == 1{
                            self.VC?.stopLoading()
                            self.VC?.productCodeStatus = 1
                            self.VC?.invoiceNumberCheckApi(invoiceNumber: self.VC?.invoiceNumberTF.text ?? "")
                        }else{
                            self.VC?.productCodeStatus = -1
                            self.VC?.view.makeToast("Summitted Len Design is not available",duration: 2.0,position: .center)
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print("No data found")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("invoice number error",error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    //    MARK: - COMBINE INVOICE NUMBER AND PRODUCT VALIDATION API
    func combine_Inv_Pro_Validation(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.checkSalesReturnStatus_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?[0].attributeId == 1{
                            self.VC?.stopLoading()
                            self.VC?.view.makeToast("This combination already exist",duration: 2.0,position: .center)
                            
                        }else if result?.lstAttributesDetails?[0].attributeId == -2{
                            self.VC?.view.makeToast("Invalid claim request",duration: 2.0,position: .center)
                        }else{
                            self.VC?.stopLoading()
                            self.VC?.hoyaValidationApi()
                            
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print("No data found")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("invoice number error",error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    //    MARK: - CLAIM SUBMISSION API
    func claimSubmissionApi(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.claimSubmission_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if result?.returnMessage == "1"{
                            self.VC?.stopLoading()
                            let vc = self.VC?.storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
                            vc?.modalTransitionStyle = .crossDissolve
                            vc?.modalPresentationStyle = .overFullScreen
                            vc?.delegate = self
                            vc?.successMessage = "Claim request has been submitted successfully"
                            self.VC?.present(vc!, animated: true)
                        }else{
                            self.VC?.stopLoading()
                            self.VC?.view.makeToast("Invalid claim request",duration: 2.0,position: .center)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print("No data found")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("invoice number error",error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func hoyaValidationApi(paramters: JSON){
        self.VC?.startLoading()
        let urlString = hoyaValidationUrl
        let url = URL(string: urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "- invoice and product status")
                DispatchQueue.main.async {
                    if str ?? "" == "false"{
                        self.VC?.productAndInvoiceValidation = "false"
                            self.VC?.stopLoading()
                        self.VC?.view.makeToast("Invalid claim request", duration: 2.0, position: .center)
                    }else if str == "true"{
                        self.VC?.productAndInvoiceValidation = "true"
                            self.VC?.stopLoading()
                            self.VC?.claimSubmission_Api()
                    }else{
                        self.VC?.productAndInvoiceValidation = "false"
                            self.VC?.stopLoading()
                        self.VC?.view.makeToast("Invalid claim request", duration: 2.0, position: .center)
                    }
                }
            }catch{
                     DispatchQueue.main.async{
                         self.VC?.stopLoading()
                         print("Invalid claim request",error.localizedDescription)
                     }
            }
        })
        task.resume()
    }
    
    
    func productListApi(parameter: JSON){
        self.promotionProductList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getPromotionDetailsProductList(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.promotionProductList = result?.lsrProductDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lsrProductDetails?.count != 0{
                            self.VC?.stopLoading()
                        }else{
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
                    print("My Redeemption error",error?.localizedDescription)
                }
            }
        }
    }
        
    
}
