//
//  UiViewControllerExtenssion.swift
//  Hoya Thailand
//
//  Created by syed on 15/02/23.
//

import Foundation
import UIKit
import Lottie


extension UIViewController{
    
//    func successMessagePopUp(message: String){
//        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
//        vc?.modalTransitionStyle = .crossDissolve
//        vc?.modalPresentationStyle = .overFullScreen
//        vc?.successMessage = message
//        present(vc!, animated: true)
//    }
    
    func lottieAnimation( animationView: LottieAnimationView){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
}

