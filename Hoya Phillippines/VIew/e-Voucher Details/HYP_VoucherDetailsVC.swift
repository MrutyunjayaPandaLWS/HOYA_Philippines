//
//  HYP_VoucherDetailsVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import WebKit
import Toast_Swift
import SDWebImage

class HYP_VoucherDetailsVC: BaseViewController ,pointsDelegate{
    
    
    func selectPointsDidTap(_ VC: RedeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        print(VC.selectedpoints)
        print(VC.productCodefromPrevious)
        print(productcodeselected,"sdkjdn")
        self.productDetails?.selectedAmount = VC.selectedpoints
        self.selectAmountLbl.text = "\(VC.selectedpoints)"

    }
    
    @IBOutlet weak var rangeAmountLbl: UILabel!
    @IBOutlet weak var selectAmountLbl: UILabel!
    @IBOutlet weak var dropDownAmountView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var voucherDetailsTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var voucherDetails: WKWebView!
    @IBOutlet weak var EnterAmountTF: UITextField!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var giftCardName: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    var totalRedeemPoint = 0
    var pointExpireDetails = [eVoucherPointExpModel]()
    var productDetails : ObjCatalogueList1?
    var currentDate = ""
    var tomorrowDate = ""
    var productcodeselected = ""
    var selectedPoints = 0
    var VM = HYP_VoucherDetailsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        voucherDetailsTextView.isEditable = false
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        setUpdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
            dashboardApi()
        }
        setUpdata()
    }
    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        if productDetails?.product_type == 1{
            let EnterAmount = Int(EnterAmountTF.text ?? "0")
            if EnterAmountTF.text?.count == 0{
                self.view.makeToast("Enter amount", duration: 2.0, position: .center)
            }else if Int(productDetails?.min_points ?? "0") ?? 0 <= Int(EnterAmountTF.text ?? "") ?? 0 && Int(productDetails?.max_points ?? "0") ?? 0 >= Int(EnterAmountTF.text ?? "") ?? 0{
                let redeemValue = Int(EnterAmountTF.text ?? "0")
                if redeemValue == 0{
                    self.view.makeToast("Redeem value shouldn't be 0", duration: 2.0, position: .center)
                    EnterAmountTF.text = ""
                }else  if totalRedeemPoint < EnterAmount!{
                    self.view.makeToast("insufficient Redeemable Balance", duration: 2.0, position: .center)
                    EnterAmountTF.text = ""
                }else{
                    if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                            vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true)
                        }
                    }else{
            //            internet is working
                        redeemVoucher(countryID: productDetails?.countryID ?? 0, catalogueID: productDetails?.catalogueId ?? 0, amount: self.EnterAmountTF.text ?? "0", productCode: productDetails?.productCode ?? "0", productImage: productDetails?.productImage ?? "", productName: productDetails?.productName ?? "", currentDate: currentDate, venderID: productDetails?.vendorId ?? 0, redemptionId: productDetails?.redemptionId ?? 0)
                    }
                    
                }
                
            }else{
                self.view.makeToast("Enter amount between min & max range", duration: 2.0, position: .center)
                EnterAmountTF.text = ""
            }
        }else{
            if self.selectAmountLbl.text == "Select Amount"{
                self.view.makeToast("Please Select amount", duration: 2.0, position: .center)
            }else{
                let redeemValue = Int(self.selectAmountLbl.text ?? "0")
                if redeemValue == 0{
                    self.view.makeToast("Redeem value shouldn't be 0", duration: 2.0, position: .center)
                    self.selectAmountLbl.text = "Select Amount"
                }else if totalRedeemPoint < redeemValue!{
                    self.view.makeToast("insufficient Redeemable Balance", duration: 2.0, position: .center)
                    self.selectAmountLbl.text = "Select Amount"
                }else{
                    if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                            vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .overFullScreen
                            self.present(vc, animated: true)
                        }
                    }else{
            //            internet is working
                        redeemVoucher(countryID: productDetails?.countryID ?? 0, catalogueID: productDetails?.catalogueId ?? 0, amount: self.selectAmountLbl.text ?? "0", productCode: productDetails?.productCode ?? "0", productImage: productDetails?.productImage ?? "", productName: productDetails?.productName ?? "", currentDate: currentDate, venderID: productDetails?.vendorId ?? 0, redemptionId: productDetails?.redemptionId ?? 0)
                    }
                    
                }
            }

        }

    }
    
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func didTappedSelectAmountBtn(_ sender: UIButton) {
        
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedeemQuantity_VC") as? RedeemQuantity_VC
            vc!.productCodefromPrevious = self.productDetails?.productCode ?? ""
            vc!.delegate = self
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        
        }
        
        
    }
    
    func dashboardApi(){
        let parameter : [String : Any] = [
                "ActorId": userId
        ]
        self.VM.dashBoardApi(parameter: parameter)
    }
    
//    func setUpdata(){
//        voucherDetailsTextView.text = productDetails?.termsCondition
//        voucherImage.sd_setImage(with: URL(string: productDetails?.productImage ?? ""), placeholderImage: UIImage(named: "ic_default_img (1)"))
//        giftCardName.text = productDetails?.productName
////        rangeAmountLbl.text = "\(productDetails?.minPoints ?? "0") - \(productDetails?.maxPoints ?? "0")"
//        availableBalanceLbl.text = "Available Balance \(redeemablePointBal)"
//    }
    
    func setUpdata(){
        voucherDetailsTextView.text = productDetails?.productDesc
        voucherImage.sd_setImage(with: URL(string: productDetails?.productImage ?? ""), placeholderImage: UIImage(named: "ic_default_img (1)"))
        giftCardName.text = productDetails?.productName
        
        if productDetails?.product_type == 1{
            dropDownAmountView.isHidden = true
            amountView.isHidden = false
            rangeAmountLbl.isHidden = false
            rangeAmountLbl.text = "\(productDetails?.min_points ?? "0") - \(productDetails?.max_points ?? "0")"
        }else{
            dropDownAmountView.isHidden = false
            amountView.isHidden = true
            rangeAmountLbl.text = ""
        }
    }
    
    func redeemVoucher(countryID: Int,catalogueID: Int,amount: String,productCode: String,productImage: String,productName: String,currentDate: String,venderID: Int,redemptionId: Int){
        let parameter : [String : Any] = [
                      "ActionType": 51,
                      "ActorId": userId,
                      "CountryCode": "THA",
                      "CountryID": "\(countryID)",
                      "lstCatalogueMobileApiJson": [
                        [
                            "CatalogueId": "\(catalogueID)",
                            "CountryCurrencyCode": "THB",
                            "DeliveryType": "in_store",
                            "HasPartialPayment": false,
                            "NoOfPointsDebit": "\(amount)",
                            "NoOfQuantity": 1,
                            "PointsRequired": "\(amount)",
                            "ProductCode": "\(productCode)",
                            "ProductImage": "\(productImage)",
                            "ProductName": "\(productName)",
                            "RedemptionDate": currentDate,
                            "RedemptionId": "\(redemptionId)",
                            "Status": 0,
                            "VendorId": "\(venderID)",
                            "VendorName": "WOGI"
                        ] as [String : Any]
                    ],
                      "ReceiverName": firstName ?? "",
                      "ReceiverEmail": customerEmail ?? "",
                      "ReceiverMobile": customerMobileNumber ?? "",
                      "SourceMode": 4
        ]
        self.VM.voucherRedeemptionApi(parameter: parameter)
    }
    
}
