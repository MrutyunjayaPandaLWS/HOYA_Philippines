//
//  HYP_MyStaffTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 21/02/23.
//

import UIKit

class HYP_MyStaffTVCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var membershipId: UILabel!
    @IBOutlet weak var enrollmentDate: UILabel!
    @IBOutlet weak var pointBalance: UILabel!
    @IBOutlet weak var staffDeginationLbl: UILabel!
    @IBOutlet weak var staffImage: UIImageView!
    @IBOutlet weak var staffNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
