//
//  HYP_SuccessMessageVC.swift
//  Hoya Philipians
//
//  Created by syed on 03/03/23.
//

import UIKit

@objc protocol SuccessMessageDelegate{
    func successMessage()
    @objc optional func successMessage3(item: HYP_SuccessMessageVC)
}

class HYP_SuccessMessageVC: UIViewController {

    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageStatusLbl: UILabel!
    var successMessage : String = ""
    var delegate : SuccessMessageDelegate?
    var itsComeFrom : String = ""
    var imageStatus = false
    override func viewDidLoad() {
        super.viewDidLoad()
        switch itsComeFrom{
        case "0":
            messageStatusLbl.isHidden = true
        case "1":
            messageStatusLbl.isHidden = true
        default:
            messageStatusLbl.isHidden =  false
        }
            successImage.isHidden = imageStatus
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageLbl.text = successMessage
    }
    
    @IBAction func didTappedOkBtn(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.successMessage()
        if itsComeFrom != ""{
            self.delegate?.successMessage3?(item: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}
