//
//  HYP_QueryListingVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation

class HYP_QueryListingVM{
    weak var VC: HYP_SupportVC?
    
    var requestAPIs = RestAPI_Requests()
    var queryList = [ObjCustomerAllQueryJsonList]()
    func getQueryList(parameter: JSON){
        self.queryList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getQuerryListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.queryList = result?.objCustomerAllQueryJsonList ?? []
                    DispatchQueue.main.async {
                        if result?.objCustomerAllQueryJsonList?.count != 0{
                            self.VC?.emptyMessage.isHidden = true
                            self.VC?.queryListTableView.reloadData()
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.emptyMessage.isHidden = false
                            self.VC?.queryListTableView.reloadData()
                            self.VC?.emptyMessage.text = "No query found"
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
                    print("Query List error",error?.localizedDescription)
                }
            }
        }
    }
}
