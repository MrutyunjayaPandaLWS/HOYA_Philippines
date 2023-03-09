//
//  HYP_OffersTVcell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

protocol OffersDelegate{
    func didTappedViewBtn(item: HYP_OffersTVcell)
}

class HYP_OffersTVcell: UITableViewCell {

    @IBOutlet weak var validDateLbl: UILabel!
    @IBOutlet weak var offersDiscountLbl: UILabel!
    @IBOutlet weak var offersName: UILabel!
    @IBOutlet weak var offersImage: UIImageView!
    var delegate: OffersDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func didTappedViewBtn(_ sender: UIButton) {
        delegate?.didTappedViewBtn(item: self)
    }
}
