//
//  HYP_CreateQueryVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import AVFoundation
import Photos
import Toast_Swift

class HYP_CreateQueryVC: BaseViewController,TopicListDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    func topicName(item: HYP_QueryTopicListVC) {
        topicNameLbl.text = item.topicName
        selectTopicId = item.selectTopicId
        queryDetailsTF.text = ""
        querySummeryTF.text = ""
    }

    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var queryDetailsTF: UITextField!
    @IBOutlet weak var querySummeryTF: UITextField!
    @IBOutlet weak var topicNameLbl: UILabel!
    var selectTopicId: Int = 0
    var queryName = "Select query"
    var strdata1 = ""
    let imagePicker = UIImagePickerController()
    var VM = HYP_CreateQueryVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        imagePicker.delegate = self
        topicNameLbl.text = queryName
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
        }
    }
    
    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        
        if topicNameLbl.text == "Select query"{
            self.view.makeToast("Select query", duration: 2.0, position: .center)
        }else if querySummeryTF.text?.count == 0{
            self.view.makeToast("Enter Query summery", duration: 2.0, position: .center)
        }else if queryDetailsTF.text?.count == 0{
            self.view.makeToast("Enter query details", duration: 2.0, position: .center)
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
    //            internet is working
                newQuerySubmission()
            }
        }
    }
    
    @IBAction func didTappedBrowseBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedSelectTopicName(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_QueryTopicListVC") as? HYP_QueryTopicListVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.actorID = "\(userId)"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    func newQuerySubmission(){
        let parameter : [String : Any] = [
                "ActionType": "0",
                "ActorId": userId,
                "CustomerName": "",
                "Email": "",
                "HelpTopic": topicNameLbl.text ?? "" ,
                "HelpTopicID": "\(selectTopicId)",
                "ImageUrl": strdata1,
                "IsQueryFromMobile": "true",
                "LoyaltyID": loyaltyId,
                "QueryDetails": queryDetailsTF.text ?? "",
                "QuerySummary": querySummeryTF.text ?? "",
                "SourceType": "1"

        ]
        self.VM.newQuerySubmission(parameter: parameter)
    }
    
    func querySubmitSuccessMessage(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.successMessage = "Query has been submitted successfully"
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
}


extension HYP_CreateQueryVC{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            queryImage.image = imagePicked.resized(withPercentage: 0.5)
            queryImage.contentMode = .scaleAspectFit
            let imageData = imagePicked.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        }
        dismiss(animated: true)
    }
    
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                self.imagePicker.allowsEditing = false
                                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.imagePicker.sourceType)!
                                self.imagePicker.sourceType = .camera
                                self.imagePicker.mediaTypes = ["public.image"]
                                self.present(self.imagePicker,animated: true,completion: nil)
                            }
                        }            } else {
                            DispatchQueue.main.async {
                                let alertVC = UIAlertController(title: "Need Camera Access", message: "Allow Camera Access", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                        }
                }} else {
                    self.noCamera()
                }
        }
    }
    
    func noCamera(){
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry no device", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.imagePicker.allowsEditing = false
                        self.imagePicker.sourceType = .photoLibrary
//                        self.imagePicker.mediaTypes = ["public.image"]
                        self.present(self.imagePicker, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery Access", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                        let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
        
    }
}
