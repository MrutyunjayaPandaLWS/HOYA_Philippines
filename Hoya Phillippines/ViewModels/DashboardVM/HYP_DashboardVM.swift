//
//  HYP_DashboardVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation
import UIKit
import Toast_Swift

class HYP_DashboardVM{
    weak var VC : HYP_DashboardVC?
    var requestAPIs = RestAPI_Requests()
    var dashboardOffers = [LstPromotionJsonList]()
    
    func dashBoardApi(parameter: JSON,completion: @escaping ()->()){
        
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
                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].memberSince, forKey: "MemberSince")
                                print(result?.objCustomerDashboardList?[0].memberSince ?? "", "Membersince")
                                print(result?.objCustomerDashboardList?[0].notificationCount ?? "", "NotificationCount")
                                print(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? "", "totalpoints")

                                self.VC?.pointsLbl.text = "\(Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0))"

                                UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].overAllPoints ?? 0, forKey: "TotalPoints")
                                UserDefaults.standard.synchronize()
                                   
                            }
                        let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                        if customerFeedbakcJSON.count != 0 {
                            if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                                DispatchQueue.main.async{
                                    completion()
                                }
                            }else{
                                let profileImg = String(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst(2)
                                print("\(PROMO_IMG1)\(profileImg), ProfilImage")
                                
                                if profileImg.count == 0{
                                    self.VC?.profileImage.image = UIImage(named: "ic_default_img")
                                }else{
                                    self.VC?.profileImage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(profileImg)"), placeholderImage: UIImage(named: "ic_default_img"))
                                }
                                UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                                self.VC?.profileName.text = "Hi, \(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "") \(result?.lstCustomerFeedBackJsonApi?[0].lastName ?? "")"
                                self.VC?.membershipIdLbl.text = result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                                
                                self.VC?.roleNameLbl.text = result?.lstCustomerFeedBackJsonApi?[0].customerType ?? ""
                                
                                UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerType, forKey: "CustomerType")
                                
                                UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId, forKey: "LoyaltyId")
                                
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                                print(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "")

                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "4", forKey: "verificationStatus")

                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "Mobile")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "", forKey: "FirstName")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].lastName ?? "", forKey: "LastName")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantId ?? "", forKey: "MerchantID")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].referralCode ?? "", forKey: "ReferralCode")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerId ?? "", forKey: "CustomerId")
                                
                                UserDefaults.standard.synchronize()
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
    

//    MARK: - DASHBOARD OFFERS SECTION API
    func dashbaordOffers(parameter: JSON){
        self.dashboardOffers.removeAll()
        self.VC?.startLoading()
        requestAPIs.dashboardOffers(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.dashboardOffers = result?.lstPromotionJsonList ?? []
                    DispatchQueue.main.async {
                        if result?.lstPromotionJsonList?.count != 0{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.offersSlideShow.addGestureRecognizer(gestureRecognizer)
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.offersSlideShow.addGestureRecognizer(gestureRecognizer)
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
    
    
    func profileaImageUpdateApi(parameter: JSON){
        self.VC?.startLoading()
        requestAPIs.profileImageUpdate_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if (result?.returnMessage == "1"){
//                            self.VC?.profileImage.sd_setImage(with: URL(string: ""), placeholderImage: <#T##UIImage?#>)
//                            self.VC?.dashboardApi()
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
//                            vc!.delegate = self
                            vc!.successMessage = "Your Profile picture is update successfuly"
                            vc!.itsComeFrom = "1"
                            vc?.imageStatus = false
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.VC?.present(vc!, animated: true, completion: nil)
                            self.VC?.stopLoading()
                            
                        }else{
//                            self.VC?.ImageSetups()
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
                    print("profileImage update error",error?.localizedDescription)
                }
            }
        }
    }
}
