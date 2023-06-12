//
//  HYP_ProgrameListVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation


class HYP_ProgrameListVM{
    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_ProgramListVC?
    var promotionList = [LtyPrgBaseDetails]()
    func prommtionsListApi(parameter: JSON){
        self.promotionList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getPromotionListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.promotionList = result?.ltyPrgBaseDetails ?? []
                    DispatchQueue.main.async {
                        if result?.ltyPrgBaseDetails?.count != 0 && result?.ltyPrgBaseDetails != nil{
                            self.VC?.emptyMessage.isHidden = true
                            self.VC?.programListTableView.reloadData()
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.emptyMessage.isHidden = false
                            self.VC?.emptyMessage.text = "No data found"
                            self.VC?.programListTableView.reloadData()
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
