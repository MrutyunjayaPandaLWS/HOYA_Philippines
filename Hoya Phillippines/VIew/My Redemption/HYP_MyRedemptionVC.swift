//
//  HYP_MyRedemptionVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyRedemptionVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate, myRedeemptionDelegate {
    func downloadVoucher(item: HYP_MyRedemptionTVCell) {
    }
    
    func didTappedFilterBtn(item: HYP_FilterVC) {
        fromDate = item.fromDate
        toDate = item.toDate
        statusId = "\(item.statusId)"
        myRedeemptionList_Api()
    }

    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var redeemptionTableView: UITableView!
    var fromDate = ""
    var toDate = ""
    var statusId = "-1"
    var startIndex = 1
    var noOfElement = 0
    var VM = HYP_MyRedemptionVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        redeemptionTableView.delegate = self
        redeemptionTableView.dataSource = self
        emptyMessage.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myRedeemptionList_Api()
    }
    
    @IBAction func didTappedFilterBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = "queryStatus"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //  MARK: - MR REDEEMPTION LIST API
        func myRedeemptionList_Api(){
            let parameter : [String : Any] =

            [
                "ActionType": 52,
                "ActorId": userId,
                 "StartIndex": startIndex,
                "NoOfRows": 10,
                "ObjCatalogueDetails": [
                    "CatalogueType": 4,
                    "MerchantId": 1,
            "JFromDate": fromDate,
                    "JToDate": toDate,
                    "RedemptionTypeId": "-1",
                    "SelectedStatus": statusId
                ],
                "Vendor":"WOGI"
            ]
            
            self.VM.myRedeemptionListApi(parameter: parameter)
        }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myRedeemptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyRedemptionTVCell", for: indexPath) as! HYP_MyRedemptionTVCell
        cell.selectionStyle = .none
        var myRedeemptionData = self.VM.myRedeemptionList[indexPath.row]
        if myRedeemptionData.status == 0 {
            cell.downloadVoucherHeight.constant = 60
            cell.statusLbl.text = "Approved"
            cell.statusLbl.textColor = approvedTextColor
            cell.statusLbl.backgroundColor = approvedBgColor
            cell.downloadVoucher = myRedeemptionData.productImage ?? ""
        }else{
            cell.downloadVoucherHeight.constant = 0
            cell.statusLbl.text = "Cancel"
            cell.statusLbl.textColor = cancelTextColor
            cell.statusLbl.backgroundColor = cancelBgColor
        }
        cell.pointsLbl.text = "\(Int(myRedeemptionData.redemptionPoints ?? 0) ) \("points")"
        cell.dateLbl.text = String(myRedeemptionData.jRedemptionDate?.dropLast(9) ?? "")
        cell.voucherNameLbl.text = myRedeemptionData.productName
        cell.productName = myRedeemptionData.productName ?? "voucher"
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == redeemptionTableView{
            if indexPath.row != (self.VM.myRedeemptionList.count - 1){
                if noOfElement == 10{
                    startIndex += 1
                    myRedeemptionList_Api()
                }else if noOfElement > 10{
                    startIndex += 1
                    myRedeemptionList_Api()
                }else if noOfElement < 10{
                    print("no need to reload")
                    return
                }else{
                    print("no more data available")
                    return
                }
            }
        }
    }
}
