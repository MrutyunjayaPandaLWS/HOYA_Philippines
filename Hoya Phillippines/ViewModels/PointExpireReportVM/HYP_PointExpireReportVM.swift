//
//  HYP_PointExpireReportVM.swift
//  Hoya Phillippines
//
//  Created by syed on 14/03/23.
//

import Foundation
class HYP_PointExpireReportVM{
    weak var VC: HYP_PointsExpiryReportVC?
    var requestAPIs = RestAPI_Requests()
    var pointExpireReportList = [LstPointsExpiryDetails]()
    var totalPointExpire: Int = 0
    func pointExpireReportApi(parameter: JSON){
        self.VC?.startLoading()
        pointExpireReportList.removeAll()
        requestAPIs.getPonintExpireReport(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.pointExpireReportList = result?.lstPointsExpiryDetails ?? []
                    DispatchQueue.main.async {
                        if result?.lstPointsExpiryDetails?.count != 0{
                            self.VC?.emptyMessage.isHidden = true
                            self.VC?.pointExpireReportTV.reloadData()
                            for list in self.pointExpireReportList {
                                self.totalPointExpire += list.pointsGoingtoExpire ?? 0
                            }
                            self.VC?.totalPointsLbl.text = "\(self.totalPointExpire)"
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.emptyMessage.isHidden = false
                            self.VC?.emptyMessage.text = "No data found"
                            self.VC?.totalPointsLbl.text = "0"
                            self.totalPointExpire = 0
                            self.VC?.pointExpireReportTV.reloadData()
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
                    print("Point Expire Report error",error?.localizedDescription)
                }
            }
        }
    }

    
    
}
