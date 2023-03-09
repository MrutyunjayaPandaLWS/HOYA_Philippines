//
//  HYP_OffersDetailsVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import WebKit

class HYP_OffersDetailsVC: UIViewController {

    @IBOutlet weak var offersDetailsTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var offerDetails: WKWebView!
    @IBOutlet weak var offerDiscountLbl: UILabel!
    @IBOutlet weak var offerNameLbl: UILabel!
    @IBOutlet weak var offersImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
