//
//  HYP_OffersVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_OffersVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,OffersDelegate{

    func didTappedViewBtn(item: HYP_OffersTVcell) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_OffersDetailsVC") as? HYP_OffersDetailsVC
        vc?.offersDetails = item.offersData
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var offersTableView: UITableView!
    var VM = HYP_OffersVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        offersTableView.delegate = self
        offersTableView.dataSource = self
        backBtnWidth.constant = 0 // 22
        emptyMessage.isHidden = true
        OffersApi()
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func OffersApi(){
        let parameter : [String : Any] = [
            "ActionType": 99,
            "ActorId": userId,
            "PromotionUserType": "HOYA"
        ]
        self.VM.dashbaordOffers(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.offersListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_OffersTVcell", for: indexPath) as! HYP_OffersTVcell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.selectionStyle = .none
        cell.offersData = self.VM.offersListArray[indexPath.row]
        cell.offersName.text = self.VM.offersListArray[indexPath.row].promotionName
        cell.validDateLbl.text = "\(self.VM.offersListArray[indexPath.row].validTo?.dropLast(9) ?? "00/00/00")"
        cell.offersImage.sd_setImage(with: URL(string: PROMO_IMG1 + (self.VM.offersListArray[indexPath.row].proImage?.dropFirst(3) ?? "")), placeholderImage: UIImage(named: "ic_default_img (1)"))
        cell.offersDiscountLbl.text = self.VM.offersListArray[indexPath.row].proShortDesc
        return cell
    }
}
