//
//  HYP_VouchersTVCell.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

protocol VoucherDelegate{
    func didTappedRedeemBtn(item: HYP_VouchersTVCell)
    func didTappedSelectAmountbtn(item: HYP_VouchersTVCell)
}

class HYP_VouchersTVCell: UITableViewCell {

    
    @IBOutlet weak var enterAmountView: UIView!
    @IBOutlet weak var selectAmountLbl: UILabel!
    @IBOutlet weak var dropdownIconView: UIView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var rangeValueLbl: UILabel!
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var voucherNameLbl: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    var delegate: VoucherDelegate?
    var voucherDetails : ObjCatalogueList1?
    var vouchersdata = [ObjCatalogueList1]()
    var selectedPoints = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        amountTF.keyboardType = .numberPad
        selectAmountLbl.text = "2"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTappedAmountBtn(_ sender: UIButton) {
        delegate?.didTappedSelectAmountbtn(item: self)
    }
    
    
    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        delegate?.didTappedRedeemBtn(item: self)
    }
}
