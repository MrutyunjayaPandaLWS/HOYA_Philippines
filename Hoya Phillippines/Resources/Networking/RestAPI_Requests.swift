//
//  RestAPI_Requests.swift
//  Millers_Customer_App
//
//  Created by ArokiaIT on 10/30/20.
//

import UIKit

typealias JSON = [String: Any]

//class RestAPI_Requests {
//    private let client = WebClient(baseUrl: baseURl)
//    
//        //Get Language List
//        func language_Api(parameters: JSON, completion: @escaping (LanguageModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: language_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(LanguageModels.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
////        //MARK: - Check StoreId existancy
//        func checkStoreIdExistancy_Api(parameters: JSON, completion: @escaping (StoreId_Existancy?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: checkStoreIdexistancy_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(StoreId_Existancy.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//
//
//    
////    MARK: - GET OTP
//    func getOTP_API(parameters: JSON, completion: @escaping (OtpModel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: getotp_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(OtpModel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    //MARK: - ROLE LISTING
//    func roleListing_API(parameters: JSON, completion: @escaping (RoleListingModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: roleListing_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(RoleListingModels.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    //MARK: - Sales Representative LISTING
//    func salesRepresentative_API(parameters: JSON, completion: @escaping (SalsRepresentativeModel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: salesRepresentative_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(SalsRepresentativeModel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    
//    //MARK: - Check S_MobileNumberExistancy
//    func s_MobileNumberExistancy_Api(parameters: JSON, completion: @escaping (S_MobileNumberExistancyModel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: ckeckUserMobileNumberExistancy_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(S_MobileNumberExistancyModel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    //MARK: - Check Email existancy
//
//    func checkEmailExistancy_Api(parameters: JSON, completion: @escaping (EmailExistancymodel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: ckeckUserEmailExistancy_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(EmailExistancymodel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    //MARK: - Login Submission
//
//    func loginApi(parameters: JSON, completion: @escaping (LoginSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: login_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(LoginSubmissionModel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//
////  MARK: - Help Topic LIST
//    func getHelpTopicList(parameters: JSON, completion: @escaping (HelpTopicModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: getHelpTopics_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(HelpTopicModels.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    
////      MARK: - New Query Submission
//        func newQuerySubmission(parameters: JSON, completion: @escaping (NewQueryModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getCustomerQueryList_UlrMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(NewQueryModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //      MARK: - New Query Submission
//            func getQuerryListApi(parameters: JSON, completion: @escaping (QueryListModel?, Error?) -> ()) -> URLSessionDataTask? {
//                return client.load(path: saveCustomerQueryTicket_URLMethod, method: .post, params: parameters) { data, error in
//                    do{
//                        if data != nil{
//                            let result1 =  try JSONDecoder().decode(QueryListModel.self, from: data as! Data)
//                            completion(result1, nil)
//                        }
//                    }catch{
//                        completion(nil, error)
//                    }
//                }
//            }
//
//    
//    //MARK: -  DashBoard API
//    func dashBoardApi(parameters: JSON, completion: @escaping (DashBoardModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(DashBoardModels.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//
////MARK: - MY EARNING LIST API
//    func myEarningListApi(parameters: JSON, completion: @escaping (My_EarningsModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: myEarningsList_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(My_EarningsModels.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    
////MARK: - GET POINT EXPIRE REPORT API
//    func getPonintExpireReport(parameters: JSON, completion: @escaping (PointExpireReportModel?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: getCustomerPointExpiryDetails_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(PointExpireReportModel.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    
//    //MARK: - GET MY REDEEMPTION LIST
//        func myRedeemptionListApi(parameters: JSON, completion: @escaping (MyRedeemptionModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myRedeemptionList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyRedeemptionModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//        
//
//    //MARK: - GET PROMOTION LIST
//        func getPromotionListApi(parameters: JSON, completion: @escaping (PromotionListModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getPromotionList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(PromotionListModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET VOUCHER LIST
//        func getVoucherListApi(parameters: JSON, completion: @escaping (VoucherModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getVoucherList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(VoucherModels.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET PROMOTION DETAILS PRODUCT LIST
//        func getPromotionDetailsProductList(parameters: JSON, completion: @escaping (ProductListModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: promotionProductList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(ProductListModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET e-VOUCHER POINT EXPIRE LIST
//        func evoucherPointExpireApi(parameters: JSON, completion: @escaping (PointExpireModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: evoucherPointExpire_UrlMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(PointExpireModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET CUSTOMER GENERAL INFO
//        func getGeneralInfo(parameters: JSON, completion: @escaping (GeneralInfoModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getCustomerDetailsMobileApp_UrlMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(GeneralInfoModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET CUSTOMER GENERAL INFO
//        func profileUpdate(parameters: JSON, completion: @escaping (ProfileUpdateModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: updateProfile_URLmethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(ProfileUpdateModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET DASHBOARD OFFERS BANNER
//        func dashboardOffers(parameters: JSON, completion: @escaping (OffersBannerModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: dashboardOffersBanner_URLmethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(OffersBannerModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    
//    //MARK: - GET MYSTAFF LISTING API
//        func myStaffListingApi(parameters: JSON, completion: @escaping (MyStaffListModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: GetStaffMemberDetails_URLmethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyStaffListModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - GET QUERY STATUS LIST API
//        func queryStatusListApi(parameters: JSON, completion: @escaping (FilterQueryStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getQueryStatusList_URLmethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(FilterQueryStatusModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - RETRIVE ACTOR ID API - LOGIN QUERY
//        func retriveActorIdApi(parameters: JSON, completion: @escaping (RetriveActorIdModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: retriveActorId_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RetriveActorIdModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - CHECK STORE USER NAME EXISTANCY - REGISTER
//        func checkStoreUserNameExistancy(parameters: JSON, completion: @escaping (StoreUserNameExistancyModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: checkStoreUserNameExistancy_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(StoreUserNameExistancyModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: - CHECK ID CARD NUMBER VALIDATION - REGISTER
//        func checkIdcardNumberValidation(parameters: JSON, completion: @escaping (IdcardValidationModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: validateIdentificationNumberHyTh_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(IdcardValidationModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    //MARK: -  REGISTRATION BOATH INDIVIDUAL & STORE OWNER
//        func registrationApi(parameters: JSON, completion: @escaping (RegistrationModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: saveCustomerRegistration_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RegistrationModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    
//    //MARK: -  VOUCHER REDEEMPTION API
//        func voucherRedeemption(parameters: JSON, completion: @escaping (VoucherRedeemptionModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: voucherRedeemption_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(VoucherRedeemptionModel.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    
//    // MARK: - CHAT QUERY DETAILS
//    func chatQuery_Post_API(parameters: JSON, completion: @escaping (ChatListModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: chat_URL_MethodName, method: .post, params: parameters) { data, error in
//            do{
////                print(data)
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(ChatListModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
//    
//    //MARK: - NEW CAHT MESSAGE SAVE API
//    func newQueryTicket_API(parameters: JSON, completion: @escaping (SubmitNwQuerModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: saveCustomerChatmessage_URLMethod, method: .post, params: parameters) { data, error in
//            do{
////                print(data)
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(SubmitNwQuerModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//}
