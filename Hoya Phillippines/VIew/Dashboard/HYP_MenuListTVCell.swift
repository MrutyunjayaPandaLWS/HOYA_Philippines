//
//  HYP_MenuListTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 18/02/23.
//

import UIKit

class HYP_MenuListTVCell: UITableViewCell {

    @IBOutlet weak var lineLbl: UILabel!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
