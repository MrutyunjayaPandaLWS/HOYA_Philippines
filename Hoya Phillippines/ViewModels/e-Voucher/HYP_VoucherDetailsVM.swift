//
//  HYP_VoucherDetailsVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation


class HYP_VoucherDetailsVM{
    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_VoucherDetailsVC?
    
    
    //    MARK: - VOUCHER REDEEMPTION API
        func voucherRedeemptionApi(parameter: JSON){
            self.VC?.startLoading()
            requestAPIs.voucherRedeemption(parameters: parameter){ result, error in
                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.VC?.successMessagePopUp(message: "Your voucher redeemed successfully")
                            
                            self.VC?.navigationController?.popViewController(animated: true)
                            self.VC?.stopLoading()
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
                        print("Voucher Redeemption error",error?.localizedDescription)
                    }
                }
            }
            DispatchQueue.main.async {
                self.VC?.stopLoading()
            }
        }
    
    
    func dashBoardApi(parameter: JSON){
        
        self.VC?.startLoading()
        self.requestAPIs.dashBoardApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    let dashboarMyVehicleDetails = result?.objImageGalleryList ?? ""
                    if dashboarMyVehicleDetails.count == 0{
                    }else{
                    }
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {
                                self.VC?.availableBalanceLbl.text = "Available Balance  \(Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0))"
                        
                        self.VC?.totalRedeemPoint = Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0)
                                UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].overAllPoints ?? "", forKey: "TotalPoints")
                                UserDefaults.standard.synchronize()
                                   
                            }
                        let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                        if customerFeedbakcJSON.count != 0 {
                            if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                                DispatchQueue.main.async{
                                }
                            }else{
                               
                            }
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
