//
//  HYP_VouchersVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift
import SDWebImage

class HYP_VouchersVC: BaseViewController,VoucherDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    //    MARK: - REDEEM BTN DELEAGTE METHOD
        func didTappedRedeemBtn(item: HYP_VouchersTVCell) {

            if item.amountTF.text?.count == 0{
                self.view.makeToast("Enter amount", duration: 2.0, position: .center)
            }else
//            else if Int(item.voucherDetails?.minPoints ?? "0") ?? 0 <= Int(item.amountTF.text ?? "") ?? 0 && Int(item.voucherDetails?.maxPoints ?? "0") ?? 0 >= Int(item.amountTF.text ?? "") ?? 0
            {
                
                let parameter : [String : Any] = [
                              "ActionType": 51,
                              "ActorId": userId,
                              "CountryCode": "THA",
                              "CountryID": "\(item.voucherDetails?.countryID ?? 0)",
                              "lstCatalogueMobileApiJson": [
                                [
                                    "CatalogueId": "\(item.voucherDetails?.catalogueID ?? 0)",
                                    "CountryCurrencyCode": "THB",
                                    "DeliveryType": "in_store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.amountTF.text ?? "0")",
                                    "NoOfQuantity": 1,
                                    "PointsRequired": "\(item.amountTF.text ?? "0")",
                                    "ProductCode": "\(item.voucherDetails?.productCode ?? "0")",
                                    "ProductImage": "\(item.voucherDetails?.productImage ?? "")",
                                    "ProductName": "\(item.voucherDetails?.productName ?? "")",
                                    "RedemptionDate": currentDate,
                                    "RedemptionId": "\(item.voucherDetails?.redemptionID ?? 0)",
                                    "Status": 0,
                                    "VendorId": "\(item.voucherDetails?.vendorID ?? 0)",
                                    "VendorName": "WOGI"
                                ]
                            ],
                              "ReceiverName": firstName ?? "",
                              "ReceiverEmail": customerEmail ?? "",
                              "ReceiverMobile": customerMobileNumber ?? "",
                              "SourceMode": 4
                ]
                self.VM.voucherRedeemptionApi(parameter: parameter)
                
                item.amountTF.text = ""
            }
//            else{
//                self.view.makeToast("Enter amount between min & max range", duration: 2.0, position: .center)
//            }
        }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var voucherListTableView: UITableView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    var VM = HYP_VoucherListVM()
    var fromDate = ""
    var toDate = ""
    var currentDate = ""
    var startIndex = 1
    var noOfElement = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        voucherListTableView.delegate = self
        voucherListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVoucherList_Api()
        getPointExpire_Api()
        currentdate()
        availableBalanceLbl.text = "Available Balance \(redeemablePointBal)"
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    

    func currentdate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        print("current date",dateString)
        currentDate = dateString
    }
    func getVoucherList_Api(){
            let parameter : [String : Any] = [
                
                    "ActionType": 6,
                    "ActorId": userId,
                     "StartIndex": startIndex,
                    "NoOfRows": "10",
                    "ObjCatalogueDetails": [
                        "CatalogueType": 4
                    ],
//                    "Vendor":"WOGI"
            ]
        
        self.VM.voucherListApi(parameter: parameter)
    }
    
    
    func getPointExpire_Api(){
        let parameter : [String : Any] = [
                "ActionType": 166,
                "RoleIDs": loyaltyId
        ]
        self.VM.expirePointsDetailsApi(parameter: parameter)
    }
    

    
    
    
//    MARK: - VOUCHER LIST TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.voucherListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_VouchersTVCell", for: indexPath) as! HYP_VouchersTVCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.voucherNameLbl.text = self.VM.voucherListArray[indexPath.row].productName
        cell.voucherImage.sd_setImage(with: URL(string: self.VM.voucherListArray[indexPath.row].productImage ), placeholderImage: UIImage(named: "ic_default_img (1)"))
        cell.voucherDetails = self.VM.voucherListArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_VoucherDetailsVC") as? HYP_VoucherDetailsVC
        vc?.pointExpireDetails = self.VM.pointExpireDetails
        vc?.productDetails = self.VM.voucherListArray[indexPath.row]
        vc?.currentDate = currentDate
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == voucherListTableView{
            if indexPath.row == (self.VM.voucherListArray.count - 1){
                if noOfElement == 10{
                    startIndex += 1
                    getVoucherList_Api()
                }else if noOfElement > 10{
                    startIndex += 1
                    getVoucherList_Api()
                }else if noOfElement < 10{
                    print("no need to reload data")
                    return
                }else{
                    print("No data available")
                    return
                }
            }
        }

    }
    
    func redeemSuccessMessage(message: String){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.successMessage = message
        present(vc!, animated: true)
    }
}
