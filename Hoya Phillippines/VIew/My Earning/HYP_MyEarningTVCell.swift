//
//  HYT_MyEarningsTVCell.swift
//  Hoya Thailand
//
//  Created by syed on 10/02/23.
//

import UIKit


class HYP_MyEarningTVCell: UITableViewCell {

    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    @IBOutlet weak var expireDateTitleLbl: UILabel!
    @IBOutlet weak var expiredateLbl: UILabel!
    @IBOutlet weak var expireDateView: NSLayoutConstraint!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var invoiceNumberLbl: UILabel!
    @IBOutlet weak var invoiceNumberTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateTitleLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productNameTitleLbl: UILabel!
    @IBOutlet weak var pointsTitleLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var promotionNameTitleLbl: UILabel!
    @IBOutlet weak var promotionNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        localization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    private func localization(){
//        productNameTitleLbl.text = "productName".localiz()
//        promotionNameTitleLbl.text = "promotionName".localiz()
//        invoiceNumberTitleLbl.text = "invoiceNumer".localiz()
//        remarksLbl.text = "remarks".localiz()
//        dateTitleLbl.text = "date".localiz()
//        pointsTitleLbl.text = "points".localiz()
//        expireDateTitleLbl.text = "point_will_expire".localiz()
//    }
}
