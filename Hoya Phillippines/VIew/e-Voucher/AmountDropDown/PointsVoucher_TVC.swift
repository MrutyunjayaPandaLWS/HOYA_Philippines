//
//  QS_PointsVoucher_TVC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 24/03/21.
//

import UIKit

class PointsVoucher_TVC: UITableViewCell {

    @IBOutlet var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
