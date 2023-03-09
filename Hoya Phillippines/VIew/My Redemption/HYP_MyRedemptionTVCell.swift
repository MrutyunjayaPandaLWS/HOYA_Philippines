//
//  HYP_MyRedemptionTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyRedemptionTVCell: UITableViewCell {

    @IBOutlet weak var downloadVoucherHeight: NSLayoutConstraint!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var voucherNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTappedDownloadVoucher(_ sender: UIButton) {
    }
}
