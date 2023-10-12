//
//  HYT_DropDownVC.swift
//  Hoya Thailand
//
//  Created by syed on 21/02/23.
//

import UIKit

@objc protocol DropdownDelegate{
    func didTappedIdCardType(item: HYP_DropDownVC)
    func didTappedGenderBtn(item: HYP_DropDownVC)
    func didTappedAccountType(item: HYP_DropDownVC)
    func didTappedRoleBtn(item: HYP_DropDownVC)
    func didTappedSalesRepresentative(item: HYP_DropDownVC)
    @objc optional func didtappedDoccumnetType(item: HYP_DropDownVC)
}

protocol FilterStatusDelegate{
    func didTappedFilterStatus(item: HYP_DropDownVC)
}

class HYP_DropDownVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var noDataFoundLbl: UILabel!
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
    var myRedeemptionStatus : [myredeemptionStatusModel] = [myredeemptionStatusModel(statusName: "Pending", statusID: 0),myredeemptionStatusModel(statusName: "Delivered", statusID: 4),myredeemptionStatusModel(statusName: "Cancelled", statusID: 3)]
    var idcardTypeList = ["Pan Card","Adhar Card","Voter Card","Passport"]
    var genderName = ""
    var promotionName = ""
    var accountType = ""
    var roleName = ""
    var roleId = 0
    var doccumentID = 0
    var doccumentName = ""
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
        case "promotionList":
            getPromotionList_Api()
        case "accountType":
            rowNumber = accountTypeList.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "myRedeemption":
            rowNumber = myRedeemptionStatus.count
            heightOfTableView.constant = CGFloat(40*rowNumber)
            dropdownTableView.reloadData()
        case "role":
            roleListApi()
        case "sales":
            salesRepresentativeAPI()
        case "idType":
            doccumentType()
        case "queryStatus":
            queryStatusApi()
        default:
            print("invalid flags")
        }
    }
    

    func roleListApi(){
        let parameter : [String : Any] = [
                "ActionType": 33,
                "RoleIDs": "HOYA"
        ]
        self.VM.roleListinApi(parameter: parameter)
    }
    
    func getPromotionList_Api(){
        let parameter : [String : Any] = [
                "ActionType": 6,
                "CustomerId": self.userId,
                "Domain": "HOYA"
        ]
        
        self.VM.prommtionsListApi(parameter: parameter)
    }
    
    func salesRepresentativeAPI(){
        let parameter : [String : Any] = [
            "ActionType": 31,
            "Actorid": locationId
        ]
        self.VM.salesRepresentativeApi(parameter: parameter)
    }

    func queryStatusApi(){
        let parameter : [String : Any] = [
                "ActionType": "150"
        ]
        self.VM.queryStatusListing(parameter: parameter)
    }
    
    func doccumentType(){
        let parameter = [
            "ActionType": 187
        ]
        self.VM.doccumentListingApi(parameter: parameter)

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
        case "promotionList":
            cell.nameLbl.text = self.VM.promotionList[indexPath.row].programName
        case "accountType":
            cell.nameLbl.text = accountTypeList[indexPath.row]
        case "myRedeemption":
            cell.nameLbl.text = myRedeemptionStatus[indexPath.row].statusName
        case "role":
            cell.nameLbl.text = self.VM.roleListArray[indexPath.row].attributeValue
        case "sales":
            cell.nameLbl.text = self.VM.salesRepresentativeList[indexPath.row].attributeValue
        case "idType":
            cell.nameLbl.text = self.VM.duccumentTypeListArray[indexPath.row].attributeType
        case "queryStatus":
            cell.nameLbl.text = self.VM.queryStatusList[indexPath.row].attributeValue
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
            
        case "promotionList":
            statusName = self.VM.promotionList[indexPath.row].programName ?? ""
            statusId = self.VM.promotionList[indexPath.row].programId ?? 0
            delegate1?.didTappedFilterStatus(item: self)
        case "accountType":
            accountType = accountTypeList[indexPath.row]
            delegate?.didTappedAccountType(item: self)

        case "myRedeemption":
            statusName = self.myRedeemptionStatus[indexPath.row].statusName ?? ""
            statusId = self.myRedeemptionStatus[indexPath.row].statusID ?? 0
            delegate1?.didTappedFilterStatus(item: self)
        case "role":
            roleId = self.VM.roleListArray[indexPath.row].attributeId ?? 0
            roleName = self.VM.roleListArray[indexPath.row].attributeValue ?? "Select role"
            delegate?.didTappedRoleBtn(item: self)
        case "sales":
            salesRepresentativeName = self.VM.salesRepresentativeList[indexPath.row].attributeValue ?? "Select sales representative"
            salesRepId = self.VM.salesRepresentativeList[indexPath.row].attributeId ?? 0
            delegate?.didTappedSalesRepresentative(item: self)
        case "idType":
            doccumentID = self.VM.duccumentTypeListArray[indexPath.row].attributeId ?? 0
            doccumentName = self.VM.duccumentTypeListArray[indexPath.row].attributeType ?? ""
            delegate?.didTappedIdCardType(item: self)
        case "queryStatus":
            statusName = self.VM.queryStatusList[indexPath.row].attributeValue ?? ""
            statusId = self.VM.queryStatusList[indexPath.row].attributeId ?? 0
            delegate1?.didTappedFilterStatus(item: self)
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
