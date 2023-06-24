//
//  HYP_HelpVM.swift
//  Hoya Phillippines
//
//  Created by syed on 13/03/23.
//

import Foundation
import Toast_Swift

class HYP_HelpVM{
    weak var VC : HYP_HelpVC?
    var requestAPIs = RestAPI_Requests()
    var queryMessage = ""
    func newQuerySubmission(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.newQuerySubmission(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    if result?.returnMessage?.count != 0{
                        self.queryMessage = result?.returnMessage ?? ""
                        DispatchQueue.main.async {
                            if self.queryMessage.contains("Saved Successfully"){
                                self.VC?.successMessagePopUp(message: "Your query has been submitted successfully.")
                                self.VC?.stopLoading()
                                
                            }else{
                                self.VC?.view.makeToast("query submit failed", duration: 2.0, position: .center)
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
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("New Query Submission error",error?.localizedDescription)
                }
            }
        }
    }
    
    
    //    MARK: -  CHECK MOBILE NUMEBR EXISTANCY
    func verifyMobileNumberAPI(paramters: JSON){
        self.VC?.startLoading()
        let url = URL(string: checkUserExistencyURL)!
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
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                print(str, "- Mobile Number Exists")
                if str ?? "" != "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.mobileNumberExistancy = -1
                        self.VC?.view.makeToast("Mobile number/memnershipId is doesn't exists", duration: 2.0, position: .center)
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.mobileNumberExistancy = 1
                        self.VC?.stopLoading()
                        self.VC?.retriveActorId()
                    }
                }
            }catch{
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                    print("mobile Number existancy Error",error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    
    
    func retriveUserId(parameter : JSON){
        self.VC?.startLoading()
        requestAPIs.retriveActorIdApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    if result?.returnMessage != "0"{
                        DispatchQueue.main.async {
                            self.VC?.actorId = "\(result?.returnValue ?? 0)"
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
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
}
