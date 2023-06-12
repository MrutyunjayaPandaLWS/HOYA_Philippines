//
//  HYP_CreateQueryVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation


class HYP_CreateQueryVM{
    weak var VC: HYP_CreateQueryVC?
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
                                self.VC?.successMessagePopUp(message: "Your query has been submitted successfully")
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
}
