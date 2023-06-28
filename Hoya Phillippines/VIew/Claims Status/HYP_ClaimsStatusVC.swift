//
//  HYP_ClaimsStatusVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_ClaimsStatusVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate {
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
        promotionId = ""
        promotionName = ""
        self.VM.myEarningList.removeAll()
        myEarningList_Api()
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var calimsStatusTableView: UITableView!
    
    var VM = HYP_ClaimStatusVM()
    var fromDate = ""
    var toDate = ""
    var promotionName = ""
    var promotionId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        calimsStatusTableView.delegate = self
        calimsStatusTableView.dataSource = self
        calimsStatusTableView.register(UINib(nibName: "HYP_MyEarningTVCell", bundle: nil), forCellReuseIdentifier: "HYP_MyEarningTVCell")
        emptyMessage.isHidden = true
        self.calimsStatusTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)
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
        }

    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = "promotionList"
        vc?.fromDate = fromDate
        vc?.toDate = toDate
        vc?.statusId = promotionId
        vc?.statusName = promotionName
        vc?.tagName = 1
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
   
    func myEarningList_Api(){
        let parameter : [String : Any] = [
            
                "ActionType": 12,
                "ActiveStatus": 1,
                "SalesPersonId": loyaltyId,
                "FromDate": fromDate,
                "ToDate": toDate,
                "ProgramID": promotionId
        ]
        self.VM.myEarningListApi(parameter: parameter)
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyEarningTVCell", for: indexPath) as! HYP_MyEarningTVCell
        cell.selectionStyle = .none
        cell.pointsView.isHidden = true
        cell.remarksLbl.text = "Status"
        cell.promotionNameTitleLbl.text = "Program Name"
        cell.expireDateView.constant = 0
        cell.productStatus.text = self.VM.myEarningList[indexPath.row].remarks ?? "-"
//        if self.VM.myEarningList[indexPath.row].salesReturn == 0 {
//            cell.productStatus.text = "Approved"
//            cell.pointsView.backgroundColor = primaryColor
//        }else{
//            cell.productStatus.text = "Cancel"
//            cell.pointsView.backgroundColor = .red
//        }
        cell.pointsLbl.text = "\(Int(self.VM.myEarningList[indexPath.row].creditedPoint ?? 0))"
        cell.invoiceNumberLbl.text = self.VM.myEarningList[indexPath.row].invoiceNo
        cell.productNameLbl.text = self.VM.myEarningList[indexPath.row].productName
        cell.dateLbl.text = String(self.VM.myEarningList[indexPath.row].trxnDate?.dropLast(9) ?? "")
        cell.promotionNameLbl.text = self.VM.myEarningList[indexPath.row].assessmentName
        
        return cell
    }

}
