//
//  HYP_DatePickerVC.swift
//  Hoya Thailand
//
//  Created by syed on 03/03/23.
//

import UIKit


protocol DateSelectedDelegate {
    func acceptDate(_ vc: HYP_DatePickerVC)
}

class HYP_DatePickerVC: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    let date = Date()
    let nameFormatter = DateFormatter()
    var selectedDate = ""
    var isComeFrom = ""
    var delegate: DateSelectedDelegate!
    var flags: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.maximumDate = date
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
    
    
    @IBAction func didTappedOkBtn(_ sender: UIButton) {
        let today = Date() //Jun 21, 2017, 7:18 PM
        let sevenDaysBeforeToday = Calendar.current.date(byAdding: .year, value: -18, to: today)!
        print(sevenDaysBeforeToday)
        if isComeFrom == "DOB"{
            if datePickerView.date > sevenDaysBeforeToday{
                let alert = UIAlertController(title: "", message: "It seems you are less than 18 years of age. You can apply for Hoya membership only if you are 18 years and above", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                selectedDate = formatter.string(from: datePickerView.date)
                self.delegate.acceptDate(self)
                self.dismiss(animated: true, completion: nil)
            }
        }else if isComeFrom == "1"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePickerView.date)
            self.delegate.acceptDate(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == "2"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePickerView.date)
            self.delegate.acceptDate(self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didTappedCancelBTn(_ sender: UIButton) {

        dismiss(animated: true)
    }
    
}
