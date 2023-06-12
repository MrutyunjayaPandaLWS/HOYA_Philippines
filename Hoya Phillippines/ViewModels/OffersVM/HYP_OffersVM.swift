//
//  HYP_OffersVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation

class HYP_OffersVM{
    weak var VC: HYP_OffersVC?
    var requestAPIs = RestAPI_Requests()
    var offersListArray = [LstPromotionJsonList]()
    
    
    //    MARK: - OFFERS SECTION API
        func dashbaordOffers(parameter: JSON){
            self.offersListArray.removeAll()
            self.VC?.startLoading()
            requestAPIs.dashboardOffers(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        self.offersListArray = result?.lstPromotionJsonList ?? []
                        DispatchQueue.main.async {
                            if self.offersListArray.count != 0{
                                self.VC?.offersTableView.reloadData()
                                self.VC?.emptyMessage.isHidden = true
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.offersTableView.reloadData()
                                self.VC?.emptyMessage.isHidden = false
                                self.VC?.emptyMessage.text = "No data found"
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
                        print("offersList error",error?.localizedDescription)
                    }
                }
            }
        }
}
