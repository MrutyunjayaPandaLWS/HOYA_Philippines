//
//  HYP_MyStaffVC.swift
//  Hoya Phillippines
//
//  Created by syed on 21/02/23.
//

import UIKit

class HYP_MyStaffVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var myStaffListTableview: UITableView!
    var VM = HYP_MyStaffVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        myStaffListTableview.delegate = self
        myStaffListTableview.dataSource = self
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
            myStaffListing_Api()
        }
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func myStaffListing_Api(){
        let parameter : [String : Any] = [
                "ActionType": 2,
                "CustomerId": userId//customerTypeID
                ]
        self.VM.myStaffListing_Api(parameter: parameter)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myStaffList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyStaffTVCell", for: indexPath) as! HYP_MyStaffTVCell
        cell.selectionStyle = .none
        cell.pointBalance.text = "\(self.VM.myStaffList[indexPath.row].customerAvalialbePointBalance ?? 0)"
        cell.enrollmentDate.text = self.VM.myStaffList[indexPath.row].customerEnrolledDate
        cell.membershipId.text = self.VM.myStaffList[indexPath.row].customerUserName
        cell.staffDeginationLbl.text = self.VM.myStaffList[indexPath.row].sE_Role
        cell.staffNameLbl.text = self.VM.myStaffList[indexPath.row].customerFirstName
        if self.VM.myStaffList[indexPath.row].status == 1{
            cell.status.text = "Active"
        }else if self.VM.myStaffList[indexPath.row].status == 0{
            cell.status.text = "Closed"
        }
        return cell
    }
    
}
