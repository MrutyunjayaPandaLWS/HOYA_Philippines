//
//  HYT_DropDownVC.swift
//  Hoya Thailand
//
//  Created by syed on 21/02/23.
//

import UIKit

protocol DropdownDelegate{
    func didTappedIdCardType(item: HYP_DropDownVC)
    func didTappedGenderBtn(item: HYP_DropDownVC)
    func didTappedAccountType(item: HYP_DropDownVC)
    func didTappedRoleBtn(item: HYP_DropDownVC)
    func didTappedSalesRepresentative(item: HYP_DropDownVC)
}

protocol FilterStatusDelegate{
    func didTappedFilterStatus(item: HYP_DropDownVC)
}

class HYP_DropDownVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var dropdownTableView: UITableView!
    var delegate: DropdownDelegate?
    var delegate1: FilterStatusDelegate?
    var rowNumber = 0
    var flags = ""
    var genderList = ["Male","Female"]
    var promotionNameList = ["promotion-A","promotion-B","promotion-C","promotion-D","promotion-E"]
    var accountTypeList = ["Individual"]
    var roleList = ["Frontliner","Individual","Manager","Optician"]
    var salesRepresentativeList = ["tester user-1","tester user-2","tester user-3"]
    var myRedeemptionStatus : [myredeemptionStatusModel] = [myredeemptionStatusModel(statusName: "Approved", statusID: 0),myredeemptionStatusModel(statusName: "Cancelled", statusID: 1)]
    var idcardTypeList = ["Pan Card","Adhar Card","Voter Card","Passport"]
    var genderName = ""
    var promotionName = ""
    var accountType = ""
    var roleName = ""
    var salesRepresentativeName = ""
    var statusName: String = ""
    var statusId:Int = 0
    var locationId = ""
    var VM = HYP_DropdownVM()
    var salesRepId = 0
    var idTypeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.VM.VC = self
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch flags{
        case "gender":
            rowNumber = genderList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "promotionName":
            rowNumber = promotionNameList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "accountType":
            rowNumber = accountTypeList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "myRedeemption":
            rowNumber = myRedeemptionStatus.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "role":
            rowNumber = roleList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "sales":
            rowNumber = salesRepresentativeList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "idType":
            rowNumber = idcardTypeList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        default:
            print("invalid flags")
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_DropDownTVCell", for: indexPath) as! HYP_DropDownTVCell
        cell.selectionStyle = .none
        switch flags{
        case "gender":
            cell.nameLbl.text = genderList[indexPath.row]
        case "promotionName":
            cell.nameLbl.text = promotionNameList[indexPath.row]
        case "accountType":
            cell.nameLbl.text = accountTypeList[indexPath.row]
        case "myRedeemption":
            cell.nameLbl.text = myRedeemptionStatus[indexPath.row].statusName
        case "role":
            cell.nameLbl.text = roleList[indexPath.row]
        case "sales":
            cell.nameLbl.text = salesRepresentativeList[indexPath.row]
        case "idType":
            cell.nameLbl.text = idcardTypeList[indexPath.row]
        default:
            print("invalid code")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch flags{
        case "gender":
            genderName = genderList[indexPath.row]
            delegate?.didTappedGenderBtn(item: self)
            
        case "promotionName":
            statusName = promotionNameList[indexPath.row]
            statusId = 0
            delegate1?.didTappedFilterStatus(item: self)
        case "accountType":
            accountType = accountTypeList[indexPath.row]
            delegate?.didTappedAccountType(item: self)

        case "myRedeemption":
            statusName = self.myRedeemptionStatus[indexPath.row].statusName
            statusId = self.myRedeemptionStatus[indexPath.row].statusID
            delegate1?.didTappedFilterStatus(item: self)
        case "role":
            roleName = roleList[indexPath.row]
            delegate?.didTappedRoleBtn(item: self)
        case "sales":
            salesRepresentativeName = salesRepresentativeList[indexPath.row]
            delegate?.didTappedSalesRepresentative(item: self)
        case "idType":
            idTypeName = idcardTypeList[indexPath.row]
            delegate?.didTappedIdCardType(item: self)
        default:
            print("invalid flags")
        }
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

}

struct myredeemptionStatusModel{
    let statusName : String
    let statusID : Int
    
}
