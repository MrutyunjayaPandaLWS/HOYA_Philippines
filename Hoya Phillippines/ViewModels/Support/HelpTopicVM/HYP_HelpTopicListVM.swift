//
//  HYP_HelpTopicListVM.swift
//  Hoya Phillippines
//
//  Created by syed on 13/03/23.
//

import Foundation


class HYT_HelptopicVM{
    weak var VC: HYP_QueryTopicListVC?
    var helpTopicList = [ObjHelpTopicList]()
    var requestAPIs = RestAPI_Requests()
    
    func getHelpTopicList_Api(parameter: JSON){
        self.helpTopicList.removeAll()
        self.VC?.startLoading()
        requestAPIs.getHelpTopicList(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    self.helpTopicList = result?.objHelpTopicList ?? []
                    DispatchQueue.main.async {
                        if result?.objHelpTopicList?.count != 0{
                            self.VC?.topicListTableView.reloadData()
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
}
