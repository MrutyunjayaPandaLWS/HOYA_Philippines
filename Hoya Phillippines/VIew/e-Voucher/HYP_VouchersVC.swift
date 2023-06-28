//
//  HYP_VouchersVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift
import SDWebImage

class HYP_VouchersVC: BaseViewController,VoucherDelegate, UITableViewDelegate, UITableViewDataSource, pointsDelegate {
    func selectPointsDidTap(_ VC: RedeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        print(VC.selectedpoints)
        print(VC.productCodefromPrevious)
        print(productcodeselected,"sdkjdn")
        let index = IndexPath(item: VC.tappedIndex, section: 0)
        self.VM.voucherListArray[VC.tappedIndex].selectedAmount = VC.selectedpoints
        self.voucherListTableView.reloadRows(at: [index], with: UITableView.RowAnimation.none)

    }
    
    func didTappedSelectAmountbtn(item: HYP_VouchersTVCell) {
        guard let tappedIndexPath = self.voucherListTableView.indexPath(for: item) else {return}
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedeemQuantity_VC") as? RedeemQuantity_VC
            vc!.productCodefromPrevious = self.VM.voucherListArray[tappedIndexPath.row].productCode ?? ""
            vc!.delegate = self
            vc?.voucherListArray = self.VM.voucherListArray
            vc!.tappedIndex = tappedIndexPath.row
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        
        }
    }
    
    
    
    //    MARK: - REDEEM BTN DELEAGTE METHOD
        func didTappedRedeemBtn(item: HYP_VouchersTVCell) {
            if item.voucherDetails?.product_type == 1{
                let EnterAmount = Int(item.amountTF.text ?? "0")
                if item.amountTF.text?.count == 0{
                    self.view.makeToast("Enter amount", duration: 2.0, position: .center)
                }else if Int(item.voucherDetails?.min_points ?? "0") ?? 0 <= Int(item.amountTF.text ?? "") ?? 0 && Int(item.voucherDetails?.max_points ?? "0") ?? 0 >= Int(item.amountTF.text ?? "") ?? 0{
                    var redeemValue = Int(item.amountTF.text ?? "0")
                    if redeemValue == 0{
                        self.view.makeToast("Redeem value shouldn't be 0", duration: 2.0, position: .center)
                        item.amountTF.text = ""
                    }else if totalRedeemPoint < EnterAmount!{
                        self.view.makeToast("insufficient Redeemable Balance", duration: 2.0, position: .center)
                        item.amountTF.text = ""
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
                            redeemVoucher(countryID: item.voucherDetails?.countryID ?? 0, catalogueID: item.voucherDetails?.catalogueId ?? 0, amount: item.amountTF.text ?? "0", productCode: item.voucherDetails?.productCode ?? "0", productImage: item.voucherDetails?.productImage ?? "", productName: item.voucherDetails?.productName ?? "", currentDate: currentDate, venderID: item.voucherDetails?.vendorId ?? 0, redemptionId: item.voucherDetails?.redemptionId ?? 0)
                            item.amountTF.text = ""
                        }
                    }
                }else{
                    self.view.makeToast("Enter amount between min & max range", duration: 2.0, position: .center)
                    item.amountTF.text = ""
                }
            }else{
                if item.selectAmountLbl.text == "Select Amount"{
                    self.view.makeToast("Please Select amount", duration: 2.0, position: .center)
                }else{
                    var redeemValue = Int(item.selectAmountLbl.text ?? "0")
                    if redeemValue == 0{
                        self.view.makeToast("Redeem value shouldn't be 0", duration: 2.0, position: .center)
                        item.selectAmountLbl.text = "Select Amount"
                    }else if totalRedeemPoint < redeemValue!{
                        self.view.makeToast("insufficient Redeemable Balance", duration: 2.0, position: .center)
                        item.amountTF.text = ""
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
                            redeemVoucher(countryID: item.voucherDetails?.countryID ?? 0, catalogueID: item.voucherDetails?.catalogueId ?? 0, amount: item.selectAmountLbl.text ?? "0", productCode: item.voucherDetails?.productCode ?? "0", productImage: item.voucherDetails?.productImage ?? "", productName: item.voucherDetails?.productName ?? "", currentDate: currentDate, venderID: item.voucherDetails?.vendorId ?? 0, redemptionId: item.voucherDetails?.redemptionId ?? 0)
                        }
                        
                    }
                }
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
                      "ReceiverEmail": "lohith.loyltwo3ks@gmail.com",
                      "ReceiverMobile": customerMobileNumber ?? "",
                      "SourceMode": 4
        ]
        print(parameter)
        self.VM.voucherRedeemptionApi(parameter: parameter)
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var voucherListTableView: UITableView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    var VM = HYP_VoucherListVM()
    var fromDate = ""
    var toDate = ""
    var currentDate = ""
    var tomorrowDate = ""
    var startIndex = 1
    var noOfElement = 0
    var totalRedeemPoint = 0
    var productcodeselected = ""
    var selectedPoints = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        emptyMessage.isHidden = true
        voucherListTableView.delegate = self
        voucherListTableView.dataSource = self
        self.voucherListTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)
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
            getVoucherList_Api()
            getPointExpire_Api()
            dashboardApi()
        }
        currentdate()
//        availableBalanceLbl.text = "Available Balance \(redeemablePointBal)"
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
                    "Vendor":"WOGI"
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
    
    func dashboardApi(){
        let parameter : [String : Any] = [
                "ActorId": userId
        ]
        print(parameter,"dashboard api")
        self.VM.dashBoardApi(parameter: parameter)
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
        cell.voucherImage.sd_setImage(with: URL(string: self.VM.voucherListArray[indexPath.row].productImage ?? ""), placeholderImage: UIImage(named: "ic_default_img (1)"))
        cell.vouchersdata.append(self.VM.voucherListArray[indexPath.row])
        cell.voucherDetails = self.VM.voucherListArray[indexPath.row]
        if self.VM.voucherListArray[indexPath.row].product_type == 1{
            cell.rangeValueLbl.isHidden = false
            cell.rangeLbl.isHidden = false
            cell.dropdownIconView.isHidden = true
            cell.rangeValueLbl.text = "\(self.VM.voucherListArray[indexPath.row].min_points ?? "0") - \(self.VM.voucherListArray[indexPath.row].max_points ?? "0")"
            cell.enterAmountView.isHidden = false
        }else{
            cell.rangeValueLbl.isHidden = true
            cell.rangeLbl.isHidden = true
            cell.dropdownIconView.isHidden = false
            cell.enterAmountView.isHidden = true
            if self.VM.voucherListArray[indexPath.row].selectedAmount == 0{
//                cell.selectAmountLbl.text = "Select Amount"
            }else{
                cell.selectAmountLbl.text = "\(self.VM.voucherListArray[indexPath.row].selectedAmount)"
            }
        }
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
