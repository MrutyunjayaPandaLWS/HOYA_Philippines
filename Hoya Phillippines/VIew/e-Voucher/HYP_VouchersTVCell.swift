//
//  HYP_VouchersTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

protocol VoucherDelegate{
    func didTappedRedeemBtn(item: HYP_VouchersTVCell)
}

class HYP_VouchersTVCell: UITableViewCell {

    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var voucherNameLbl: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    var delegate: VoucherDelegate?
    var voucherDetails : ObjCatalogueList1?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        delegate?.didTappedRedeemBtn(item: self)
    }
}
