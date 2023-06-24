//
//  SearchableDropDownVM.swift
//  Hoya Thailand
//
//  Created by admin on 14/06/23.
//

import Foundation

class SearchableDropDownVM{
    
    
    weak var VC: SelectDealerDropDownVC?
    var requestAPIs = RestAPI_Requests()
    var promotionProductList = [LsrProductDetails]()
    var promotionProductList1 = [LsrProductDetails]()
    
    func productListApi(parameter: JSON){
        self.promotionProductList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getPromotionDetailsProductList(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.promotionProductList = result?.lsrProductDetails?.compactMap{$0} ?? []
                    self.promotionProductList1 = result?.lsrProductDetails?.compactMap{$0} ?? []
                    
                    DispatchQueue.main.async {
                        if result?.lsrProductDetails?.count != 0{
                            self.VC?.tableViewHeightConstraint.constant = CGFloat(45*self.promotionProductList.count)
                            self.VC?.rowNumber = self.promotionProductList.count
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.tableViewHeightConstraint.constant = CGFloat(45*self.promotionProductList.count)
                            self.VC?.tableViewHeightConstraint.constant = CGFloat(45*self.promotionProductList.count)
                            self.VC?.dropDownTableView.reloadData()
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
