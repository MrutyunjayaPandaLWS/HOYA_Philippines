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
    var offersDetails : LstPromotionJsonList?
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        setup()
    }

    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        offersImage.sd_setImage(with: URL(string: PROMO_IMG1 + (offersDetails?.proImage?.dropFirst(3) ?? "")), placeholderImage: UIImage(named: "ic_default_img (1)"))
        offerNameLbl.text = offersDetails?.promotionName
        offerDiscountLbl.text = offersDetails?.proShortDesc
        offersDetailsTextView.text = offersDetails?.proLongDesc
    }
}
