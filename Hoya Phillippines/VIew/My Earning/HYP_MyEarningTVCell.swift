//
//  HYP_MyEarningTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyEarningTVCell: UITableViewCell {

    @IBOutlet weak var promotionNameTitleLbl: UILabel!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var salesReturnLbl: UILabel!
    @IBOutlet weak var invoiceNumberLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var promotionNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
