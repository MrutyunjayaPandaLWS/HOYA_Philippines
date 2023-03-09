//
//  HYP_SuccessMessageVC.swift
//  Hoya Philipians
//
//  Created by syed on 03/03/23.
//

import UIKit

protocol SuccessMessageDelegate{
    func successMessage()
}

class HYP_SuccessMessageVC: UIViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageStatusLbl: UILabel!
    var successMessage : String = ""
    var delegate : SuccessMessageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageLbl.text = successMessage
    }
    
    @IBAction func didTappedOkBtn(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.successMessage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}
