//
//  HYP_ProgramListVC.swift
//  Hoya Phillippines
//
//  Created by syed on 20/02/23.
//

import UIKit

class HYP_ProgramListVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var programListTableView: UITableView!
    var VM = HYP_ProgrameListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        programListTableView.delegate  = self
        programListTableView.dataSource = self
        self.programListTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)

        
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
            getPromotionList_Api()
            
        }
    }

    @IBAction func didTappedNotificationbtn(_ sender: UIButton) {
    }
    
    @IBAction func didtappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func getPromotionList_Api(){
        let parameter : [String : Any] = [
                   "ActionType": 6,
                   "CustomerId": userId,
                   "Domain": "HOYA"
        ]
        
        self.VM.prommtionsListApi(parameter: parameter)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.promotionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_ProgramListTVCell", for: indexPath) as! HYP_ProgramListTVCell
        cell.selectionStyle = .none
        cell.programDetailsLbl.text = self.VM.promotionList[indexPath.row].programDesc
        cell.programNameLbl.text = self.VM.promotionList[indexPath.row].programName
        cell.ValidDateLbl.text = "\("valid Untli") : \(self.VM.promotionList[indexPath.row].jEndDate?.prefix(10) ?? "")"
        cell.promotionData = self.VM.promotionList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_ClaimDetailsVC") as? HYP_ClaimDetailsVC
        vc?.promotionData = self.VM.promotionList[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
}
