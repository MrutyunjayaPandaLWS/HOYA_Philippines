//
//  HYP_MyRedemptionVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyRedemptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {}
    


    @IBOutlet weak var redeemptionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        redeemptionTableView.delegate = self
        redeemptionTableView.dataSource = self
    }
    
    @IBAction func didTappedFilterBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = ""
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyRedemptionTVCell", for: indexPath) as! HYP_MyRedemptionTVCell
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.downloadVoucherHeight.constant = 60
            cell.statusLbl.text = "Approved"
            cell.statusLbl.textColor = approvedTextColor
            cell.statusLbl.backgroundColor = approvedBgColor
        }else{
            cell.downloadVoucherHeight.constant = 0
            cell.statusLbl.text = "Cancel"
            cell.statusLbl.textColor = cancelTextColor
            cell.statusLbl.backgroundColor = cancelBgColor
        }
        
        return cell
    }
}
