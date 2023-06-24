import UIKit


class HYP_RedeemQuantity_VM{
    weak var VC: RedeemQuantity_VC?

    var requestAPIs = RestAPI_Requests()
    var pointsArray = [ObjCatalogueFixedPoints]()
    var filteredpointsArray = [ObjCatalogueFixedPoints]()
    
//    func data(userID: String, productCode: String){
//
//
//
//
//                    DispatchQueue.main.async {
//                        self.pointsArray = self.VC?.voucherListArray.objCatalogueFixedPoints ?? []
//                        for product in self.pointsArray{
//                            if product.productCode == productCode{
//                                self.filteredpointsArray.append(product)
//                            }
//                        }
//                        self.VC?.tableViewHeight.constant = CGFloat(self.filteredpointsArray.count * 30)
//                        self.VC?.pointsTableView.reloadData()
//                        self.VC?.stopLoading()
//                    }
//
//
//    }
    
    func myVouchersAPI(userID: String, productCode: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"6",
            "ActorId":"\(self.VC?.userId)",
            "ObjCatalogueDetails":
                [
                    "CatalogueType":"4",
                    "MerchantId":"1"
                ],
            "Vendor": "WOGI"
        ] as [String : Any]
        
        print(parameters)
        self.requestAPIs.getVoucherListApi(parameters: parameters, completion: { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.pointsArray = result?.objCatalogueFixedPoints ?? []
                        for product in self.pointsArray{
                            if product.productCode == productCode{
                                self.filteredpointsArray.append(product)
                            }
                        }
                        self.VC?.tableViewHeight.constant = CGFloat(self.filteredpointsArray.count * 30)
                        self.VC?.pointsTableView.reloadData()
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
        })
    }
}
