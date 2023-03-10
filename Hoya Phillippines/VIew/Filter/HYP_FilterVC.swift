//
//  HYP_FilterVC.swift
//  Hoya Thailand
//
//  Created by syed on 10/02/23.
//

import UIKit
import Toast_Swift

protocol FilterProtocolDelegate{
    func didTappedFilterBtn(item: HYP_FilterVC)
}

class HYP_FilterVC: UIViewController, FilterStatusDelegate, DateSelectedDelegate {
    func acceptDate(_ vc: HYP_DatePickerVC) {
        if vc.isComeFrom == "1"{
            fromDate = vc.selectedDate
            fromDateLbl.text = vc.selectedDate
        }else{
            toDate = vc.selectedDate
            toDateLbl.text = vc.selectedDate
        }
    }
    
    func didTappedFilterStatus(item: HYP_DropDownVC) {
        statusName = item.statusName
        statusId = item.statusId
        selectPromotionNameLbl.text = statusName
    }
    
    func didTappedPromotionName(item: HYP_DropDownVC) {
        selectPromotionNameLbl.text = item.promotionName
    }

    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var promotionNameViewHeight: NSLayoutConstraint!
//    @IBOutlet weak var resetBtn: UIButton!
//    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var selectPromotionNameLbl: UILabel!
//    @IBOutlet weak var filterLbl: UILabel!
    
    var delegate: FilterProtocolDelegate?
    var promotionNameHeight = 38
    var bottomConstraintsValue = 30
    var fromDate = ""
    var toDate = ""
    var flags = ""
    var statusName = ""
    var statusId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        promotionNameViewHeight.constant = CGFloat(promotionNameHeight)
        bottomConstraints.constant = CGFloat(bottomConstraintsValue)
        
    }
    
    @IBAction func didTappedTodateBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DatePickerVC") as? HYP_DatePickerVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        vc?.isComeFrom = "2"
        present(vc!, animated: true)
    }
    @IBAction func didtappedFromDateBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DatePickerVC") as? HYP_DatePickerVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        vc?.isComeFrom = "1"
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedSelectPromotionBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate1 = self
        vc?.flags = "promotionName"
        present(vc!, animated: true)
    }
   
//    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
//    {
//        let touch = touchscreen.first
//        if touch?.view != self.presentingViewController
//        {
//            self.dismiss(animated: true, completion: nil)
//
//        }
//    }
    
    @IBAction func didTappedResetBtn(_ sender: UIButton) {
        selectPromotionNameLbl.text = "Select"
        fromDateLbl.text = "From Date"
        toDateLbl.text = "To Date"
        fromDate = ""
        toDate = ""
    }

    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
        
        if fromDateLbl.text == "From Date" || toDateLbl.text == "To Date"{
            self.view.makeToast("Select date", duration: 2.0, position: .center)
        }else if fromDate > toDate {
            self.view.makeToast("invalid date range", duration: 2.0, position: .center)
        }else{
            delegate?.didTappedFilterBtn(item: self)
            dismiss(animated: true)
        }
    }
    
    @IBAction func didTappedCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
