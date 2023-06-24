//
//  HYP_LoginVM.swift
//  Hoya Phillippines
//
//  Created by syed on 13/03/23.
//

import Foundation
import UIKit

class HYP_HYP_LoginVM{
    weak var VC : HYP_LoginVC?
    var requestAPIs = RestAPI_Requests()
    var timmer = Timer()
    var count = 0
    var otpNumber = ""
    
    
    //    MARK: -  CHECK MOBILE NUMEBR EXISTANCY
        func verifyMobileNumberAPI(paramters: JSON){
            self.VC?.startLoading()
            let url = URL(string: checkUserExistencyURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")

            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let str = String(decoding: data, as: UTF8.self) as String?
                     print(str, "- Mobile Number Existancy")
                    if str ?? "" != "1"{
                        DispatchQueue.main.async{
                            self.VC?.stopLoading()
                            self.VC?.mobileNumberExistancy = -1
                            self.VC?.view.makeToast("Membership ID / Mobile number is doesn't exists", duration: 2.0, position: .center)
                        }
                    }else{
                        DispatchQueue.main.async{
                            self.VC?.mobileNumberExistancy = 1
                            self.VC?.stopLoading()
                            self.VC?.sendOtptoRegisterNumber()
                        }
                    }
                     }catch{
                         DispatchQueue.main.async{
                             self.VC?.stopLoading()
                             print("mobile Number existancy Error",error.localizedDescription)
                         }
                }
            })
            task.resume()
        }
    
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                 request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
            }
        }
    
    
    //    MARK: - LOGIN SUBMISSION
        func loginSubmissionApi(parameter: JSON){
            self.VC?.startLoading()
            requestAPIs.loginApi(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        if result?.userList?.count != 0{
                            DispatchQueue.main.async {
                                let data = result?.userList?[0]
                                if data?.result != 1{
                                    if self.VC?.mobileNumberExistancy != 1{
                                        self.VC?.view.makeToast("Membership ID / Mobile number is doesn't exists", duration: 2.0, position: .center)
                                        self.VC?.stopLoading()
                                    }else{
                                        self.VC?.view.makeToast("Password is incorrect", duration: 2.0, position: .center)
                                        self.VC?.stopLoading()
                                    }
                                }else{
                                    if data?.isUserActive == 1{
                                        if data?.verifiedStatus == 4 {
                                            self.VC?.stopLoading()
                                                self.VC?.view.makeToast("Your account verification is pending, please contact to your administrator", duration: 2.0, position: .center)
                                        }else if data?.verifiedStatus == 2 {
                                            self.VC?.stopLoading()
                                                self.VC?.view.makeToast("Your account login is faild, please contact to your administrator", duration: 2.0, position: .center)
                                        }else{
                                        self.VC?.stopLoading()
                                        UserDefaults.standard.set(data?.customerTypeID, forKey: "customerTypeID")
                                        UserDefaults.standard.set(data?.userName, forKey: "userName")
                                        UserDefaults.standard.set(data?.userId, forKey: "userId")
                                        UserDefaults.standard.set(data?.merchantName, forKey: "merchantName")
                                        UserDefaults.standard.set(data?.merchantEmailID, forKey: "merchantEmailID")
                                        UserDefaults.standard.set(data?.merchantMobileNo, forKey: "merchantMobileNo")
                                        UserDefaults.standard.set(data?.mobile, forKey: "mobile")
                                        UserDefaults.standard.set(data?.email, forKey: "email")
                                        UserDefaults.standard.set(data?.custAccountNumber, forKey: "custAccountNumber")
                                        UserDefaults.standard.set(data?.userImage, forKey: "userImage")
                                        UserDefaults.standard.set(data?.locationName, forKey: "locationName")
                                        UserDefaults.standard.set(true, forKey: "UserLoginStatus")
                                        if #available(iOS 13.0, *) {
                                            let sceneDelegate = self.VC?.view.window!.windowScene!.delegate as! SceneDelegate
                                            sceneDelegate.setHomeAsRootViewController()
                                        } else {
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            appDelegate.setHomeAsRootViewController()
                                        }
                                    }
                                        
                                    }else{
                                        self.VC?.stopLoading()
                                        self.VC?.view.makeToast("Your account is deactivate please contact to your administrator", duration: 2.0, position: .center)
                                    }
                                    
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
        
     
    
    //    MARK: - GET OTP API
    func getOtpApi(parameter: JSON){
            self.VC?.startLoading()
            requestAPIs.getOTP_API(parameters: parameter) { result, error in
                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.timmer.invalidate()
                            self.VC?.otpView1.isHidden =  false
                            self.VC?.otpView.isUserInteractionEnabled = true
                            self.VC?.otpBtnStatus = 1
                            self.VC?.SubmitBtn.setTitle("Submit", for: .normal)
                            self.count = 60
                            self.timmer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
//                            self.VC?.sendotp = 1
                            self.otpNumber = result?.returnMessage ?? ""
                            print("OTP - " , self.otpNumber)
                            self.VC?.stopLoading()
                        }
                    }else{
                        DispatchQueue.main.async {
//                            self.VC?.sendotp = 0
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
    
    @objc func update() {
        if(self.count > 1) {
            self.count = Int(self.count) - 1
            self.VC?.timmerLbl.text = "00:\(self.count)"
            self.VC?.timmerLbl.isHidden = false
            self.VC?.resendBtn.isHidden = true
           
        }else{
            self.timmer.invalidate()
//            self.VC?.sendotp = 0
            self.VC?.timmerLbl.text = "00:00"
            self.VC?.timmerLbl.isHidden = true
            self.VC?.resendBtn.isHidden = false
        }
    }
}
