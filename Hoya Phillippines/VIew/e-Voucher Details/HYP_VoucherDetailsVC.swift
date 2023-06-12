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

class HYP_VoucherDetailsVC: BaseViewController {

    @IBOutlet weak var voucherDetailsTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var voucherDetails: WKWebView!
    @IBOutlet weak var EnterAmountTF: UITextField!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var giftCardName: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    var pointExpireDetails = [eVoucherPointExpModel]()
    var productDetails : ObjCatalogueList1?
    var currentDate = ""
    var VM = HYP_VoucherDetailsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        setUpdata()
    }
    

    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        if EnterAmountTF.text?.count == 0{
            self.view.makeToast("Enter redeem amount",duration: 2.0,position: .center)
        }else{
            let parameter : [String : Any] = [
                          "ActionType": 51,
                          "ActorId": userId,
                          "CountryCode": "THA",
                          "CountryID": "\(productDetails?.countryID ?? 0)",
                          "lstCatalogueMobileApiJson": [
                            [
                                "CatalogueId": "\(productDetails?.catalogueID ?? 0)",
                                "CountryCurrencyCode": "THB",
                                "DeliveryType": "in_store",
                                "HasPartialPayment": false,
                                "NoOfPointsDebit": "\(EnterAmountTF.text ?? "0")",
                                "NoOfQuantity": 1,
                                "PointsRequired": "\(EnterAmountTF.text ?? "0")",
                                "ProductCode": "\(productDetails?.productCode ?? "0")",
                                "ProductImage": "\(productDetails?.productImage ?? "")",
                                "ProductName": "\(productDetails?.productName ?? "")",
                                "RedemptionDate": currentDate,
                                "RedemptionId": "\(productDetails?.redemptionID ?? 0)",
                                "Status": 0,
                                "VendorId": "\(productDetails?.vendorID ?? 0)",
                                "VendorName": "WOGI"
                            ]
                        ],
                          "ReceiverName": firstName ?? "",
                          "ReceiverEmail": customerEmail ?? "",
                          "ReceiverMobile": customerMobileNumber ?? "",
                          "SourceMode": 4
                    

            ]
            self.VM.voucherRedeemptionApi(parameter: parameter)
        }
    }
    
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    
    func setUpdata(){
        voucherDetailsTextView.text = productDetails?.termsCondition
        voucherImage.sd_setImage(with: URL(string: productDetails?.productImage ?? ""), placeholderImage: UIImage(named: "ic_default_img (1)"))
        giftCardName.text = productDetails?.productName
//        rangeAmountLbl.text = "\(productDetails?.minPoints ?? "0") - \(productDetails?.maxPoints ?? "0")"
        availableBalanceLbl.text = "Available Balance \(redeemablePointBal)"
    }
}
