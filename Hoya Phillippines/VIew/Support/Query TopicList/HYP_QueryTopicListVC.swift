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
    var topicList : [TopicList] = [TopicList(topicName: "Enrolment Related", topicImage: "user1", helptoicID: 3),
                                   TopicList(topicName: "Redemption Related", topicImage: "guarantee", helptoicID: 7 ),
                                   TopicList(topicName: "Unable to use mobile app", topicImage: "mobile-development", helptoicID: 9),
                                   TopicList(topicName: "Unable to raise purchase claim", topicImage: "error", helptoicID: 1),//mark
                                   TopicList(topicName: "Complaints", topicImage: "cyber-security", helptoicID: 13),
                                   TopicList(topicName: "Point Related", topicImage: "cancel", helptoicID: 1),//mark
                                   TopicList(topicName: "Product Complaints", topicImage: "return", helptoicID: 12),//mark
                                   TopicList(topicName: "Feedback", topicImage: "feedback", helptoicID: 14),
                                   TopicList(topicName: "Information about program", topicImage: "barcode", helptoicID: 11)
    ]
    var delegate : TopicListDelegate?
    var topicName = ""
    var selectTopicId = 0
    var actorID = ""
    var flags = 0
    var VM = HYT_HelptopicVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        topicListTableView.delegate = self
        topicListTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flags == 0{
            helpTopicList_Api()
        }   
        
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
            print(parameter,"helpTopicList_Api")
            self.VM.getHelpTopicList_Api(parameter: parameter)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flags == 0{
            tableViewHeight.constant = CGFloat(70*self.VM.helpTopicList.count)
            return  self.VM.helpTopicList.count
        }else{
            tableViewHeight.constant = CGFloat(70*self.topicList.count)
            return  topicList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_QueryTopicListTVCell", for: indexPath) as! HYP_QueryTopicListTVCell
        cell.selectionStyle = .none
        if flags == 0{
            cell.topicNameLbl.text =  self.VM.helpTopicList[indexPath.row].helpTopicName
            cell.topicNameImage.isHidden = true
        }else{
            cell.topicNameLbl.text = topicList[indexPath.row].topicName
            cell.topicNameImage.image = UIImage(named: topicList[indexPath.row].topicImage)
            cell.topicNameImage.isHidden = false
        }
//        cell.topicNameLbl.text = topicList[indexPath.row].topicName
//        cell.topicNameImage.image = UIImage(named: topicList[indexPath.row].topicImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if flags == 0{
            topicName = self.VM.helpTopicList[indexPath.row].helpTopicName ?? ""
            selectTopicId = self.VM.helpTopicList[indexPath.row].helpTopicId ?? 0
        }else{
            topicName = self.topicList[indexPath.row].topicName
            selectTopicId = self.topicList[indexPath.row].helptoicID
        }
        
        dismiss(animated: true){
            self.delegate?.topicName(item: self)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
}


struct TopicList{
    let topicName : String
    let topicImage : String
    let helptoicID : Int
}
