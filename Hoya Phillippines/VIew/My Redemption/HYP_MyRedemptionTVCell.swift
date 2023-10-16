//
//  HYP_MyRedemptionTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

protocol myRedeemptionDelegate{
    func downloadVoucher(item: HYP_MyRedemptionTVCell)
}

class HYP_MyRedemptionTVCell: UITableViewCell {

    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var downloadVoucherHeight: NSLayoutConstraint!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var voucherNameLbl: UILabel!
    var downloadVoucher:String = ""
    var delegate : myRedeemptionDelegate?
    var productName = ""
    var pdfLink = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusLbl.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func didTappedDownloadVoucher(_ sender: UIButton) {
        delegate?.downloadVoucher(item: self)
    }
}
