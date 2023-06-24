//
//  HYP_VoucherListVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation

class HYP_VoucherListVM: SuccessMessageDelegate{
    func successMessage() {
        self.VC?.navigationController?.popToRootViewController(animated: true)
    }
    
    
    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_VouchersVC?
    var voucherListArray = [ObjCatalogueList1]()
    var pointExpireDetails = [eVoucherPointExpModel]()
    func voucherListApi(parameter: JSON){
//        self.voucherListArray.removeAll()
        self.VC?.startLoading()
        requestAPIs.getVoucherListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        let voucherList = result?.objCatalogueList ?? []
                        if voucherList.count != 0 && voucherList.isEmpty == false {
                            self.voucherListArray += voucherList
                            self.VC?.noOfElement = self.voucherListArray.count
                            if self.voucherListArray.count != 0{
                                self.VC?.emptyMessage.isHidden = true
                                self.VC?.voucherListTableView.reloadData()
                                self.VC?.stopLoading()
                            }else{
                                self.VC?.emptyMessage.isHidden = false
                                self.VC?.startIndex = 1
                                self.VC?.noOfElement = 0
                                self.VC?.voucherListTableView.reloadData()
                                self.VC?.emptyMessage.text = "No data found"
                                self.VC?.stopLoading()
                            }
                            
                        }else{
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.emptyMessage.text = "No data found"
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
    
//    MARK: - VOUCHER EXPIRE DETAILS API
    func expirePointsDetailsApi(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.evoucherPointExpireApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.pointExpireDetails = result?.lstAttributesDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?.count != 0 {

                            self.VC?.stopLoading()
                        }else{
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
                    print("My VOUCHER EXPIRE error",error?.localizedDescription)
                }
            }
        }
    }

    
    //    MARK: - VOUCHER REDEEMPTION API
        func voucherRedeemptionApi(parameter: JSON){
            self.VC?.startLoading()
            requestAPIs.voucherRedeemption(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        let message = result?.returnMessage?.split(separator: "-")
                        let message1 = message?[1].split(separator: "-")
                        if  Int(message1?[0] ?? "0")! > 0{
                            DispatchQueue.main.async {
                                
                                let vc = self.VC?.storyboard?.instantiateViewController(withIdentifier: "HYT_SuccessMessageVC") as? HYP_SuccessMessageVC
                                vc?.modalTransitionStyle = .crossDissolve
                                vc?.modalPresentationStyle = .overFullScreen
                                vc?.successMessage = "Your voucher redeemed successfully"
                                vc?.delegate = self
                                self.VC?.present(vc!, animated: true)
                                self.VC?.dashboardApi()
                                
                                self.VC?.stopLoading()
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.VC?.view.makeToast("Something went to wrong, please try after some time...",duration: 2.0,position: .center)
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
                                self.VC?.availableBalanceLbl.text = "Available Balance \(Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0))"
                        self.VC?.totalRedeemPoint = Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0)

                                UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].overAllPoints ?? 0, forKey: "TotalPoints")
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
