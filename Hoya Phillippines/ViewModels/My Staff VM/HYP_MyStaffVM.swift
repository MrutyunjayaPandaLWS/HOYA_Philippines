//
//  HYP_MyStaffVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation


class HYP_MyStaffVM{
    weak var VC : HYP_MyStaffVC?
    var requestAPIs = RestAPI_Requests()
    var myStaffList = [LstCustomerEntityMapping]()
    
    //    MARK: - DASHBOARD OFFERS SECTION API
        func myStaffListing_Api(parameter: JSON){
            self.myStaffList.removeAll()
            self.VC?.startLoading()
            requestAPIs.myStaffListingApi(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        self.myStaffList = result?.lstCustomerEntityMapping ?? []
                        DispatchQueue.main.async {
                            if result?.lstCustomerEntityMapping?.count != 0{
                                self.VC?.myStaffListTableview.reloadData()
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.myStaffListTableview.reloadData()
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
                        print("roleListin error",error?.localizedDescription)
                    }
                }
            }
        }
    
    
}
