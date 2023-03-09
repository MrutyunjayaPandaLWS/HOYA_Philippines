//
//  HYP_VouchersVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Toast_Swift


class HYP_VouchersVC: BaseViewController,VoucherDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var voucherListTableView: UITableView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        voucherListTableView.delegate = self
        voucherListTableView.dataSource = self
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
//    MARK: - REDEEM BTN DELEAGTE METHOD
    func didTappedRedeemBtn(item: HYP_VouchersTVCell) {
        if item.amountTF.text?.count == 0{
            self.view.makeToast("Enter redeem amount",duration: 2.0,position: .center)
        }else{
            redeemSuccessMessage(message: "Your voucher redeemed successfully")
        }
        
    }
    
//    MARK: - VOUCHER LIST TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_VouchersTVCell", for: indexPath) as! HYP_VouchersTVCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_VoucherDetailsVC") as? HYP_VoucherDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func redeemSuccessMessage(message: String){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.successMessage = message
        present(vc!, animated: true)
    }
}
