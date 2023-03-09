//
//  qq.swift
//  Hoya Phillippines
//
//  Created by syed on 03/03/23.
//
import Foundation
import UIKit

class HYP_DropdownVM{
    
//    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_DropDownVC?
//    var roleList = [LstAttributesDetails2]()
//    var salesRepresentativeList = [LstAttributesDetails3]()
//    var queryStatusList = [LstAttributesDetails5]()
//    var promotionList = [LtyPrgBaseDetails]()
//
//    func roleListinApi(parameter: JSON){
//        self.roleList.removeAll()
//        self.VC?.startLoading()
//        requestAPIs.roleListing_API(parameters: parameter) { result, error in
//            if error == nil{
//                if result != nil{
//                    self.roleList = result?.lstAttributesDetails ?? []
//                    DispatchQueue.main.async {
//                        if result?.lstAttributesDetails?.count != 0{
//                            self.VC?.heightOfTableView.constant = CGFloat(30*self.roleList.count)
//                            self.VC?.rowNumber = self.roleList.count
//                            self.VC?.dropdownTableView.reloadData()
//                            self.VC?.stopLoading()
//
//                        }else{
//                            self.VC?.stopLoading()
//                        }
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                    print("roleListin error",error?.localizedDescription)
//                }
//            }
//        }
//    }
//
//
//    func salesRepresentativeApi(parameter: JSON){
//        self.salesRepresentativeList.removeAll()
//        self.VC?.startLoading()
//        requestAPIs.salesRepresentative_API(parameters: parameter) { result, error in
//            if error == nil{
//                if result != nil{
//                    self.salesRepresentativeList = result?.lstAttributesDetails ?? []
//                    DispatchQueue.main.async {
//                        if result?.lstAttributesDetails?.count != 0{
//                            self.VC?.heightOfTableView.constant = CGFloat(30*self.salesRepresentativeList.count)
//                            self.VC?.rowNumber = self.salesRepresentativeList.count
//                            self.VC?.dropdownTableView.reloadData()
//                            self.VC?.stopLoading()
//
//                        }else{
//                            self.VC?.stopLoading()
//                        }
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                    print("salesRepresentativeAPi error",error?.localizedDescription)
//                }
//            }
//        }
//    }
//
//
//    func queryStatusListing(parameter: JSON){
//        self.queryStatusList.removeAll()
//        self.VC?.startLoading()
//        requestAPIs.queryStatusListApi(parameters: parameter) { result, error in
//            if error == nil{
//                if result != nil{
//                    self.queryStatusList = result?.lstAttributesDetails ?? []
//                    DispatchQueue.main.async {
//                        if result?.lstAttributesDetails?.count != 0{
//                            self.VC?.heightOfTableView.constant = CGFloat(30*self.queryStatusList.count)
//                            self.VC?.rowNumber = self.queryStatusList.count
//                            self.VC?.dropdownTableView.reloadData()
//                            self.VC?.stopLoading()
//                        }else{
//                            self.VC?.stopLoading()
//                        }
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                    print("salesRepresentativeAPi error",error?.localizedDescription)
//                }
//            }
//        }
//    }
//
//
//
//    func prommtionsListApi(parameter: JSON){
//        self.promotionList.removeAll()
//        self.VC?.startLoading()
//        requestAPIs.getPromotionListApi(parameters: parameter) { result, error in
//            if error == nil{
//                if result != nil{
//                    self.promotionList = result?.ltyPrgBaseDetails ?? []
//                    DispatchQueue.main.async {
//                        if result?.ltyPrgBaseDetails?.count != 0 && result?.ltyPrgBaseDetails != nil{
//                            self.VC?.heightOfTableView.constant = CGFloat(30*self.promotionList.count)
//                            self.VC?.rowNumber = self.promotionList.count
//                            self.VC?.dropdownTableView.reloadData()
//                            self.VC?.stopLoading()
//                        }else{
//                            self.VC?.heightOfTableView.constant = CGFloat(30*self.promotionList.count)
//                            self.VC?.dropdownTableView.reloadData()
//                            self.VC?.stopLoading()
//                        }
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }
//            else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                    print("My Redeemption error",error?.localizedDescription)
//                }
//            }
//        }
//    }

}
