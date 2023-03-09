//
//  HYP_ProgramListTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 20/02/23.
//

import UIKit

class HYP_ProgramListTVCell: UITableViewCell {

    @IBOutlet weak var programDetailsLbl: UILabel!
    @IBOutlet weak var programNameLbl: UILabel!
    @IBOutlet weak var ValidDateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
