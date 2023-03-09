//
//  HYP_SupportVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_SupportVC: UIViewController, UITableViewDelegate, UITableViewDataSource,TopicListDelegate, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {}
    
    func topicName(item: HYP_QueryTopicListVC) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_CreateQueryVC") as? HYP_CreateQueryVC
        vc?.queryName = item.topicName
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var queryListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        queryListTableView.delegate = self
        queryListTableView.dataSource = self
        backBtnWidth.constant = 0 //22
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
        vc?.flags = ""
        vc?.delegate = self
        present(vc!, animated: true)
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_SupportTVCell", for: indexPath) as! HYP_SupportTVCell
        cell.selectionStyle = .none
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
