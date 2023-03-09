//
//  HYP_ClaimDetailsVC.swift
//  Hoya Phillippines
//
//  Created by syed on 20/02/23.
//

import UIKit
import Toast_Swift

class HYP_ClaimDetailsVC: BaseViewController, FilterStatusDelegate {
    func didTappedFilterStatus(item: HYP_DropDownVC) {
        productNameLbl.text = item.statusName
    }
    

    @IBOutlet weak var quantityTF: UITextField!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var invoiceNumberTF: UITextField!
    @IBOutlet weak var validDate: UILabel!
    
    @IBOutlet weak var programName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        if invoiceNumberTF.text?.count == 0{
            self.view.makeToast("Enter invoice number", duration: 2.0, position: .center)
        }else if productNameLbl.text == "Select Product Name"{
            self.view.makeToast("Select Product Name", duration: 2.0, position: .center)
        }else if quantityTF.text?.count == 0{
            self.view.makeToast("Enter Product Name", duration: 2.0, position: .center)
        }else{
            successMessagePopUp(message: "Claim request has been submitted successfully")
        }
        
    }
    @IBAction func didTappedCancelBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedSelectProductNameBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_DropDownVC") as? HYP_DropDownVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate1 = self
        vc?.flags = "promotionName"
        present(vc!, animated: true)
    }
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
