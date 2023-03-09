//
//  HYP_VoucherDetailsVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import WebKit
import Toast_Swift

class HYP_VoucherDetailsVC: BaseViewController {

    @IBOutlet weak var voucherDetailsTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var voucherDetails: WKWebView!
    @IBOutlet weak var EnterAmountTF: UITextField!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var giftCardName: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    

    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        if EnterAmountTF.text?.count == 0{
            self.view.makeToast("Enter redeem amount",duration: 2.0,position: .center)
        }else{
            successMessagePopUp(message: "Your voucher redeemed successfully")
        }
    }
    
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
}
