//
//  HYP_SupportVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_SupportVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,TopicListDelegate, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {
        fromDate = item.fromDate
        toDate = item.toDate
        programId = "\(item.statusId)"
        getQueryList_Api()
    }
    
    func topicName(item: HYP_QueryTopicListVC) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_CreateQueryVC") as? HYP_CreateQueryVC
        vc?.queryName = item.topicName
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var queryListTableView: UITableView!
    var VM = HYP_QueryListingVM()
    var fromDate = ""
    var toDate = ""
    var programId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        queryListTableView.delegate = self
        queryListTableView.dataSource = self
        backBtnWidth.constant = 0 //22
        getQueryList_Api()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromDate = ""
        toDate = ""
        programId = ""
        getQueryList_Api()
    }
    
    @IBAction func didTappedNewQueryBtn(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_CreateQueryVC") as? HYP_CreateQueryVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = "queryStatus"
        vc?.delegate = self
        present(vc!, animated: true)
        
    }

    
    func getQueryList_Api(){
        let parameter : [String : Any] = [

                    "ActionType": "1",
                    "ActorId": userId,
                    "HelpTopicID": "-1",
                    "TicketStatusId": programId,
                    "JFromDate": fromDate,
                    "JToDate": toDate,
                    "QueryStatus":""
                
        ]
        self.VM.getQueryList(parameter: parameter)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.queryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_SupportTVCell", for: indexPath) as! HYP_SupportTVCell
        cell.selectionStyle = .none
        cell.selectionStyle = .none
        cell.queryNumberLbl.text = self.VM.queryList[indexPath.row].customerTicketRefNo
        cell.queryDateLbl.text = "\(self.VM.queryList[indexPath.row].jCreatedDate?.dropLast(9) ?? "")"
        cell.timaeLbl.text = "\(self.VM.queryList[indexPath.row].jCreatedDate?.suffix(8) ?? "")"
        cell.queryStatusLbl.text = self.VM.queryList[indexPath.row].ticketStatus
        cell.queryDetailsLbl.text = self.VM.queryList[indexPath.row].queryDetails
        if self.VM.queryList[indexPath.row].ticketStatus == "Pending"{
            cell.querySTatusView.backgroundColor = pendingStatusColor
        }else if self.VM.queryList[indexPath.row].ticketStatus == "Resolved"{
            cell.querySTatusView.backgroundColor = approvedTextColor
        }else if self.VM.queryList[indexPath.row].ticketStatus == "Closed"{
            cell.querySTatusView.backgroundColor = cancelTextColor
        }else{
            cell.querySTatusView.backgroundColor = cancelTextColor
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_Chatvc2ViewController") as! HR_Chatvc2ViewController
//        vc.CustomerTicketIDchatvc = self.VM.queryList[indexPath.row].customerTicketID ?? 0
//        print(vc.CustomerTicketIDchatvc, "CustomerChat ID")
//        vc.helptopicid = self.VM.queryList[indexPath.row].helpTopicID ?? 0
//        vc.helptopicName = self.VM.queryList[indexPath.row].helpTopic ?? ""
//        vc.helptopicdetails = self.VM.queryList[indexPath.row].querySummary ?? ""
//        vc.querydetails = self.VM.queryList[indexPath.row].queryDetails ?? ""
//        vc.querysummary = self.VM.queryList[indexPath.row].querySummary ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
