//
//  HYP_MyEarningVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyEarningVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {
        fromDate = item.fromDate
        toDate = item.toDate
        promotionName = item.statusName
        promotionId = "\(item.statusId)"
        myEarningList_Api()
        
    }
    func didTappedResetFilterBtn(item: HYP_FilterVC) {
        fromDate = ""
        toDate = ""
        promotionName = ""
        promotionId = ""
        myEarningList_Api()
    }

    @IBOutlet weak var availablePointsLbl: UILabel!
    @IBOutlet weak var availablePointsTitleLbl: UILabel!
    @IBOutlet weak var expiredPointsLbl: UILabel!
    @IBOutlet weak var expiredPointsTitleLbl: UILabel!
    @IBOutlet weak var redeemPointsTitleLbl: UILabel!
    @IBOutlet weak var redeemedPointsLbl: UILabel!
    @IBOutlet weak var earnedPointTitleLbl: UILabel!
    @IBOutlet weak var earnedPointLbl: UILabel!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var myEarnigTableView: UITableView!
    var VM = HYP_MyEarningsVM()
    var fromDate = ""
    var toDate = ""
    var promotionName = ""
    var promotionId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        myEarnigTableView.register(UINib(nibName: "HYP_MyEarningTVCell", bundle: nil), forCellReuseIdentifier: "HYP_MyEarningTVCell")
        myEarnigTableView.delegate = self
        myEarnigTableView.dataSource = self
        emptyMessage.isHidden = true
        self.myEarnigTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)
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
            myEarningList_Api()
//            getPointExpireReportDetails()
        }
    }
    
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.flags = "promotionList"
        vc?.fromDate = fromDate
        vc?.toDate = toDate
        vc?.statusId = promotionId
        vc?.statusName = promotionName
        vc?.tagName =  1
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func myEarningList_Api(){
        let parameter : [String : Any] = [
            
                "ActionType": 7,
                "ActiveStatus": 1,
                "SalesPersonId": loyaltyId,
                "FromDate": fromDate,
                "ToDate": toDate,
                "ProgramID": promotionId
        ]
        print(parameter,"myEarningList_Api")
        self.VM.myEarningListApi(parameter: parameter)
    }
    
    
    func getPointExpireReportDetails(){
        let parameter : [String : Any] = [
            "ActionType": 1,
            "LoyaltyId": "\(self.loyaltyId)",
                "FromDate": fromDate,
                "ToDate": toDate
            
        ]
        print(parameter,"point expire report")
        self.VM.pointExpireReportApi(parameter: parameter)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyEarningTVCell", for: indexPath) as! HYP_MyEarningTVCell
        cell.selectionStyle = .none
//        cell.remarksLbl.text = "Remarks"
//        cell.promotionNameTitleLbl.text = "Promotion Name"
        if self.VM.myEarningList[indexPath.row].remarks?.contains("Reward Adjustment") == true{
            cell.expireDateView.constant = 0
            cell.productStatus.text = "Reward Adjustment"
            cell.pointsView.backgroundColor = primaryColor
        }else if self.VM.myEarningList[indexPath.row].remarks?.contains("Points Credited") == true{
            cell.expireDateView.constant = 40
            let expDate = self.VM.myEarningList[indexPath.row].pointExpiryDate?.split(separator: " ")
            cell.expiredateLbl.text = "\(expDate?[0] ?? "")"
            cell.productStatus.text = "Point credited"
            cell.pointsView.backgroundColor = primaryColor
        }else{
            cell.expireDateView.constant = 0
            cell.productStatus.text = "Sale Return"
            cell.pointsView.backgroundColor = .red
            
        }
        cell.pointsLbl.text = "\(Int(self.VM.myEarningList[indexPath.row].creditedPoint ?? 0))"
        cell.invoiceNumberLbl.text = self.VM.myEarningList[indexPath.row].invoiceNo ?? "-"
        cell.productNameLbl.text = self.VM.myEarningList[indexPath.row].productName ?? "-"
        let date = self.VM.myEarningList[indexPath.row].trxnDate?.split(separator: " ")
        cell.dateLbl.text = String(date?[0] ?? "-")
        cell.promotionNameLbl.text = self.VM.myEarningList[indexPath.row].assessmentName ?? "-"
        return cell
    }

}
