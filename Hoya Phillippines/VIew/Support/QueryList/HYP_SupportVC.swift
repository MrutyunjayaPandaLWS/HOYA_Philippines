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
        programId = item.statusId
        programName = item.statusName
        getQueryList_Api()
    }
    
    func didTappedResetFilterBtn(item: HYP_FilterVC) {
        fromDate = ""
        toDate = ""
        programId = ""
        programName = ""
        getQueryList_Api()
    }
    
    func topicName(item: HYP_QueryTopicListVC) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_CreateQueryVC") as? HYP_CreateQueryVC
        vc?.queryName = item.topicName
        vc?.selectTopicId = item.selectTopicId
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var queryListTableView: UITableView!
    var VM = HYP_QueryListingVM()
    var fromDate = ""
    var toDate = ""
    var programId = ""
    var programName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        queryListTableView.delegate = self
        queryListTableView.dataSource = self
        backBtnWidth.constant = 0 //22
        self.queryListTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromDate = ""
        toDate = ""
        programId = ""
        programName = ""
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
            getQueryList_Api()
        }
    }
    
    @IBAction func didTappedNewQueryBtn(_ sender: UIButton) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_CreateQueryVC") as? HYP_CreateQueryVC
//        navigationController?.pushViewController(vc!, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_QueryTopicListVC") as? HYP_QueryTopicListVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.actorID = "\(userId)"
        vc?.flags = 1
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.flags = "queryStatus"
        vc?.statusId = programId
        vc?.statusName = programName
        vc?.fromDate = fromDate
        vc?.toDate = toDate
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
        vc.CustomerTicketIDchatvc = self.VM.queryList[indexPath.row].customerTicketID ?? 0
        print(vc.CustomerTicketIDchatvc, "CustomerChat ID")
        vc.helptopicid = self.VM.queryList[indexPath.row].helpTopicID ?? 0
        vc.helptopicName = self.VM.queryList[indexPath.row].helpTopic ?? ""
        vc.helptopicdetails = self.VM.queryList[indexPath.row].querySummary ?? ""
        vc.querydetails = self.VM.queryList[indexPath.row].queryDetails ?? ""
        vc.querysummary = self.VM.queryList[indexPath.row].querySummary ?? ""
        if self.VM.queryList[indexPath.row].ticketStatus == "Closed"{
            vc.ChatMessageEnable = true
        }else{
            vc.ChatMessageEnable = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
