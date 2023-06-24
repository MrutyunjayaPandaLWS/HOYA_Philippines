//
//  SuccessMessage2.swift
//  Hoya Thailand
//
//  Created by admin on 17/06/23.
//

import UIKit


protocol popMessage2Delegate{
    func didTappedOKBtn(item: SuccessMessage2)
//    func didtappedCancelBtn()
}
class SuccessMessage2: UIViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    var delegate: popMessage2Delegate?
    var message = ""
    var vcTitle = ""
    var btnName = ""
    var flags = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if message == ""{
            messagelbl.isHidden = true
        }else{
            messagelbl.isHidden = false
            messagelbl.text = message
        }
        if vcTitle != ""{
            headerLbl.isHidden = false
            headerLbl.text =  vcTitle
        }else{
            headerLbl.isHidden = true
        }
        if btnName == ""{
            okBtn.setTitle("OK", for: .normal)
        }else{
            okBtn.setTitle(btnName, for: .normal)
        }
        cancelBtn.setTitle("Cancel", for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func didTappedOkBtn(_ sender: Any) {
        delegate?.didTappedOKBtn(item: self)
    }
    
    @IBAction func didTappedCancelBtn(_ sender: Any) {
//        delegate?.didTappedOKBtn()
        dismiss(animated: true)
        
    }
    
    
    
}
