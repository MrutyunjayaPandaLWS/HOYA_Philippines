//
//  HYP_MyRedemptionVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation

class HYP_MyRedemptionVM{
    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_MyRedemptionVC?
    var myRedeemptionList = [ObjCatalogueRedemReqList]()
    func myRedeemptionListApi(parameter: JSON){
//        self.myRedeemptionList.removeAll()
        self.VC?.startLoading()
        requestAPIs.myRedeemptionListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    let myRedeemptionListArray = result?.objCatalogueRedemReqList ?? []
                    if myRedeemptionListArray.isEmpty == false || myRedeemptionListArray.count != 0 {
                        self.myRedeemptionList = self.myRedeemptionList + myRedeemptionListArray
                        DispatchQueue.main.async {
                            self.VC?.noOfElement = self.myRedeemptionList.count
                            if self.myRedeemptionList.count != 0{
                                self.VC?.emptyMessage.isHidden = true
                                self.VC?.redeemptionTableView.reloadData()
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.noOfElement = 0
                                self.VC?.startIndex = 1
                                self.VC?.emptyMessage.isHidden = false
                                self.VC?.emptyMessage.text = "No data found!"
                                self.VC?.redeemptionTableView.reloadData()
                                self.VC?.stopLoading()
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            if self.myRedeemptionList.count == 0{
                                self.VC?.noOfElement = 0
                                self.VC?.startIndex = 1
                                self.VC?.emptyMessage.isHidden = false
                                self.VC?.emptyMessage.text = "No data found!"
                                self.VC?.redeemptionTableView.reloadData()
                            }
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.emptyMessage.isHidden = false
                        self.VC?.emptyMessage.text = "No data found!"
                        self.VC?.redeemptionTableView.reloadData()
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.emptyMessage.text = "No data found"
                    print("My Redeemption error",error?.localizedDescription)
                }
            }
        }
    }
    
}
