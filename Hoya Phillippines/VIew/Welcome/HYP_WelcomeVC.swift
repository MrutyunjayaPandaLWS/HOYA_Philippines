//
//  HYP_WelcomeVC.swift
//  Hoya Phillippines
//
//  Created by syed on 16/02/23.
//

import UIKit

class HYP_WelcomeVC: UIViewController {

    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var registerImage: UIImageView!
    @IBOutlet weak var storeOwnerLbl: UILabel!
    @IBOutlet weak var storeOwnerImage: UIImageView!
    @IBOutlet weak var loginIndividualLbl: UILabel!
    @IBOutlet weak var loginIndividualImage: UIImageView!
    @IBOutlet weak var chooseYourselfLbl: UILabel!
    @IBOutlet weak var welcomeInfoLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var bottomVIew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomVIew.clipsToBounds = true
        bottomVIew.layer.cornerRadius = 30
        bottomVIew.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        welcomeView.clipsToBounds = true
        welcomeView.layer.cornerRadius = 30
        welcomeView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    @IBAction func didTappedRegisterBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_RegisterVC") as? HYP_RegisterVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func didTappedStoreOwnerBtn(_ sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "StoreOwner")
        UserDefaults.standard.set(0, forKey: "Individual")
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_LoginVC") as? HYP_LoginVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedLoginIndividualBtn(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "StoreOwner")
        UserDefaults.standard.set(1, forKey: "Individual")
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_LoginVC") as? HYP_LoginVC
        navigationController?.pushViewController(vc!, animated: true)
    }
}

