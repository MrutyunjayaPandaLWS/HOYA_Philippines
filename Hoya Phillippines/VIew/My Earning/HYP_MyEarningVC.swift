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
       

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myEarningList_Api()
    }
    
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = "promotionList"
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
        self.VM.myEarningListApi(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyEarningTVCell", for: indexPath) as! HYP_MyEarningTVCell
        cell.selectionStyle = .none
        cell.remarksLbl.text = "Remarks"
        cell.promotionNameTitleLbl.text = "Promotion Name"
        if self.VM.myEarningList[indexPath.row].salesReturn == 0 {
            cell.salesReturnLbl.text = "Point Credit"
            cell.pointsView.backgroundColor = primaryColor
        }else{
            cell.salesReturnLbl.text = "Sale Return"
            cell.pointsView.backgroundColor = .red
        }
        cell.pointsLbl.text = "\(Int(self.VM.myEarningList[indexPath.row].creditedPoint ?? 0))"
        cell.invoiceNumberLbl.text = self.VM.myEarningList[indexPath.row].invoiceNo
        cell.productNameLbl.text = self.VM.myEarningList[indexPath.row].productName
        cell.dateLbl.text = String(self.VM.myEarningList[indexPath.row].trxnDate?.dropLast(9) ?? "")
        cell.promotionNameLbl.text = self.VM.myEarningList[indexPath.row].assessmentName
        return cell
    }

}