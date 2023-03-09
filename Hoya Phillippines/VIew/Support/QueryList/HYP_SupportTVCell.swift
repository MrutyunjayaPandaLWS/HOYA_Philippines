//
//  HYP_SupportTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_SupportTVCell: UITableViewCell {

    @IBOutlet weak var queryDetailsLbl: UILabel!
    @IBOutlet weak var timaeLbl: UILabel!
    @IBOutlet weak var queryDateLbl: UILabel!
    @IBOutlet weak var querySTatusView: UIView!
    @IBOutlet weak var queryStatusLbl: UILabel!
    @IBOutlet weak var queryNumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
