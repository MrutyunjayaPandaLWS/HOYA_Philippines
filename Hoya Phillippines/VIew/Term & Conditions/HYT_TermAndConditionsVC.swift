//
//  HYT_TermAndConditionsVC.swift
//  Hoya Thailand
//
//  Created by syed on 29/03/23.
//

import UIKit
import WebKit

protocol CheckBoxSelectDelegate{
    func accept(_ vc: HYT_TermAndConditionsVC)
    func decline(_ vc: HYT_TermAndConditionsVC)
}

class HYT_TermAndConditionsVC: BaseViewController {

    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    var delegate : CheckBoxSelectDelegate?
    var requestAPIs = RestAPI_Requests()
    var termsAndConditionArray = [LstTermsAndCondition]()
    var languageName = UserDefaults.standard.string(forKey: "LanguageName") ?? "EN"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localization()
        termsAndConditionApi()
    }
    @IBAction func selectAcceptBtn(_ sender: UIButton) {
        delegate?.accept(self)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectDeclineBtn(_ sender: UIButton) {
        delegate?.decline(self)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    private func localization(){
//        titleVC.text = "Terms And Condition".localiz()
    }
    
    func termsAndConditionApi(){
        DispatchQueue.main.async {
        self.startLoading()
        }
        let parameters = [
            "ActionType": 1,
             "ActorId": 2
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.termsAndCondition_API(parameters: parameters, completion: { result, error in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.termsAndConditionArray = result?.lstTermsAndCondition ?? []
                        if self.termsAndConditionArray.count == 0{
                            DispatchQueue.main.async{

                            }
                        }else{
                            for item in self.termsAndConditionArray{
                                if item.language == "English"{
                                    
                                    self.loadHTMLStringImage(htmlString: item.html ?? "")
                                    return
                                }
                            }
                            
//                            if self.languageName == "EN"{
//                                for item in self.termsAndConditionArray{
//                                    if item.language == "English"{
//
//                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
//                                        return
//                                    }
//                                }
//                            }else{
//                                for item in self.termsAndConditionArray{
//                                    if item.language == "Thai"{
//
//                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
//                                        return
//                                    }
//                                }
//                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        })
    }

    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        webView.loadHTMLString(htmlString, baseURL: nil)
       }

}
