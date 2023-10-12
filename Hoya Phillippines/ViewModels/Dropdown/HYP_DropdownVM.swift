//
//  qq.swift
//  Hoya Phillippines
//
//  Created by syed on 03/03/23.
//
import Foundation
import UIKit

class HYP_DropdownVM{
    
    var requestAPIs = RestAPI_Requests()
    weak var VC: HYP_DropDownVC?
    var roleListArray = [LstAttributesDetails2]()
    var salesRepresentativeList = [LstAttributesDetails3]()
    var queryStatusList = [LstAttributesDetails5]()
    var promotionList = [LtyPrgBaseDetails]()
    var duccumentTypeListArray = [DoccumentType]()
    func roleListinApi(parameter: JSON){
        self.roleListArray.removeAll()
        self.VC?.startLoading()
        requestAPIs.roleListing_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        for data in result?.lstAttributesDetails ?? []{
                            if data.attributeValue ?? "" != "Store Owner"{
                                self.roleListArray.append(data)
                            }
                        }
                                
                        if self.roleListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.roleListArray.count)
                            self.VC?.rowNumber = self.roleListArray.count
                            
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.heightOfTableView.constant = 45
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.noDataFoundLbl.isHidden = false
                        self.VC?.heightOfTableView.constant = 45
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
    
    
    func salesRepresentativeApi(parameter: JSON){
        self.salesRepresentativeList.removeAll()
        self.VC?.startLoading()
        requestAPIs.salesRepresentative_API(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.salesRepresentativeList = result?.lstAttributesDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.salesRepresentativeList.count)
                            self.VC?.rowNumber = self.salesRepresentativeList.count
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.heightOfTableView.constant = 45
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.noDataFoundLbl.isHidden = false
                        self.VC?.heightOfTableView.constant = 45
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("salesRepresentativeAPi error",error?.localizedDescription)
                }
            }
        }
    }
    
    func doccumentListingApi(parameter: JSON){
        self.salesRepresentativeList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getDoccumentTypeListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.duccumentTypeListArray = result?.lstAttributesDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.duccumentTypeListArray.count)
                            self.VC?.rowNumber = self.duccumentTypeListArray.count
                            self.VC?.dropdownTableView.reloadData()
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
                    print("salesRepresentativeAPi error",error?.localizedDescription)
                }
            }
        }
    }
    
    func queryStatusListing(parameter: JSON){
        self.queryStatusList.removeAll()
        self.VC?.startLoading()
        requestAPIs.queryStatusListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.queryStatusList = result?.lstAttributesDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lstAttributesDetails?.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.queryStatusList.count)
                            self.VC?.rowNumber = self.queryStatusList.count
                            self.VC?.dropdownTableView.reloadData()
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
                    print("salesRepresentativeAPi error",error?.localizedDescription)
                }
            }
        }
    }
    

    
    func prommtionsListApi(parameter: JSON){
        self.promotionList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getPromotionListApi(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.promotionList = result?.ltyPrgBaseDetails ?? []
                    DispatchQueue.main.async {
                        if result?.ltyPrgBaseDetails?.count != 0 && result?.ltyPrgBaseDetails != nil{
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.promotionList.count)
                            self.VC?.rowNumber = self.promotionList.count
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.promotionList.count)
                            self.VC?.heightOfTableView.constant = CGFloat(45*self.promotionList.count)
                            self.VC?.dropdownTableView.reloadData()
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
