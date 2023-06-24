//
//  HistoryNotificationsViewModel.swift
//  Hoya Phillippines
//
//  Created by admin on 23/06/23.
//

import UIKit

class HistoryNotificationsViewModel{
    
    weak var VC: HistoryNotificationsViewController?
    var requestAPIs = RestAPI_Requests()
    var notificationListArray = [LstPushHistoryJson]()
    
    func notificationListApi(parameters: JSON, completion: @escaping (NotificationModels?) -> ()){
        DispatchQueue.main.async {
              self.VC?.startLoading()
         }
        self.requestAPIs.notificationList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }

}

