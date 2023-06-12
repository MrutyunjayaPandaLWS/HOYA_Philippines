//
//  HYP_QueryTopicListVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit


protocol TopicListDelegate{
    func topicName(item : HYP_QueryTopicListVC)
}


class HYP_QueryTopicListVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topicListTableView: UITableView!
    var topicList : [TopicList] = [TopicList(topicName: "Enrolment Related", topicImage: "user1"),
                                   TopicList(topicName: "Redemption Related", topicImage: "guarantee"),
                                   TopicList(topicName: "Unable to use mobile app", topicImage: "mobile-development"),
                                   TopicList(topicName: "Unable to raise purchase claim", topicImage: "error"),
                                   TopicList(topicName: "Complaints", topicImage: "cyber-security"),
                                   TopicList(topicName: "Point Related", topicImage: "cancel"),
                                   TopicList(topicName: "Product Complaints", topicImage: "return"),
                                   TopicList(topicName: "Feedback", topicImage: "feedback"),
                                   TopicList(topicName: "Information about program", topicImage: "barcode"),
    ]
    var delegate : TopicListDelegate?
    var topicName = ""
    var selectTopicId = 0
    var actorID = ""
    var VM = HYT_HelptopicVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        topicListTableView.delegate = self
        topicListTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helpTopicList_Api()
    }
    
    @IBAction func didTappedCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: - getHelpTopicList_Api
        
        func helpTopicList_Api(){
            let parameter : [String : Any] = [
                    "ActionType": "4",
                    "ActorId": "\(self.actorID)",
                    "IsActive": "true"
            ]
            self.VM.getHelpTopicList_Api(parameter: parameter)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeight.constant = CGFloat(70*topicList.count)
        return topicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_QueryTopicListTVCell", for: indexPath) as! HYP_QueryTopicListTVCell
        cell.selectionStyle = .none
        cell.topicNameLbl.text = topicList[indexPath.row].topicName
        cell.topicNameImage.image = UIImage(named: topicList[indexPath.row].topicImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicName = self.VM.helpTopicList[indexPath.row].helpTopicName ?? ""
        selectTopicId = self.VM.helpTopicList[indexPath.row].helpTopicId ?? 0
        delegate?.topicName(item: self)
        dismiss(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
}


struct TopicList{
    let topicName : String
    let topicImage : String
}
