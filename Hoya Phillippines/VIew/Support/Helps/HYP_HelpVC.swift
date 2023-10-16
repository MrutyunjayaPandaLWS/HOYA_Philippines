//
//  HYP_HelpVC.swift
//  Hoya Phillippines
//
//  Created by syed on 16/02/23.
//

import UIKit
import AVFoundation
import Photos
import Toast_Swift

class HYP_HelpVC: BaseViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, TopicListDelegate {
    func topicName(item: HYP_QueryTopicListVC) {
        selectQueryTopicLbl.text = item.topicName
        selectQueryTopicLbl.textColor = .black
        self.selectTopicId = item.selectTopicId
        querySummeryTF.text = ""
    }
    

    @IBOutlet weak var uploadImageBtnView: UIView!
    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var bottonView: UIView!
    @IBOutlet weak var querySummeryTF: UITextField!
    @IBOutlet weak var selectQueryTopicLbl: UILabel!
    @IBOutlet weak var membershipIdTF: UITextField!
    var strdata1 = ""{
        didSet{
            if strdata1 == ""{
                self.queryImage.isHidden = true
                self.uploadImageBtnView.isHidden = false
            }else{
                self.queryImage.isHidden = false
                self.uploadImageBtnView.isHidden = true
            }
        }
    }
    let imagePicker = UIImagePickerController()
    var VM = HYP_HelpVM()
    var mobileNumberExistancy: Int = -1
    var actorId:String = ""
    var selectTopicId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        imagePicker.delegate = self
        bottonView.layer.cornerRadius = 30
        bottonView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottonView.clipsToBounds = true
        backBtnWidth.constant = 0
    
    }
    @IBAction func didTappedBackToLoginBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMembershipID(_ sender: UITextField) {
        mobileNumberExistancyApi()
    }
    @IBAction func didTappedSubmitBtn(_ sender: UIButton) {
        if membershipIdTF.text?.count == 0 {
            self.view.makeToast("Enter MembershipID", duration: 2.0, position: .center)
        }else if selectQueryTopicLbl.text == "Select Query Topic"{
            self.view.makeToast("Select Query Topic", duration: 2.0, position: .center)
        } else if querySummeryTF.text?.count == 0 {
            self.view.makeToast("Enter query summery", duration: 2.0, position: .center)
        }else if mobileNumberExistancy == -1{
            self.view.makeToast("MembershipId is invalid", duration: 2.0, position: .center)
        }else{
            newQuerySubmission()
        }
    }
    @IBAction func didTappedUploadImage(_ sender: UIButton) {
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
    @IBAction func didTappedBackBtn(_ sender: Any) {
    }
   
    @IBAction func didTappedSelectTopic(_ sender: Any) {
        if membershipIdTF.text?.count == 0{
            self.view.makeToast("Enter membershipId")
        }else if mobileNumberExistancy == -1{
            self.view.makeToast("Enter a valid membershipID")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_QueryTopicListVC") as? HYP_QueryTopicListVC
            vc?.modalPresentationStyle = .overFullScreen
            vc?.modalTransitionStyle = .crossDissolve
            vc?.delegate = self
            vc?.actorID = actorId
            present(vc!, animated: true)
        }

    }
    
    func retriveActorId(){
        let parameter : [String : Any] = [
            
                "ActionType": 276,
                "Location":[
                    "UserName": membershipIdTF.text ?? ""
                ]
        ]
        self.VM.retriveUserId(parameter: parameter)
    }
    
    func mobileNumberExistancyApi(){
        let parameter : [String : Any] = [
                "ActionType": "57",
                "Location": [
                    "UserName" : "\(membershipIdTF.text ?? "")"
                ]
        ]
        VM.verifyMobileNumberAPI(paramters: parameter)
//        56875434356
    }
    
    func newQuerySubmission(){
        let parameter : [String : Any] = [
                "ActionType": "0",
                "ActorId": actorId,
                "CustomerName": "",
                "Email": "",
                "HelpTopic": selectQueryTopicLbl.text ?? "" ,
                "HelpTopicID": "\(selectTopicId)",
                "ImageUrl": strdata1,
                "IsQueryFromMobile": "true",
                "LoyaltyID": membershipIdTF.text ?? "",
                "QueryDetails": querySummeryTF.text ?? "",
                "QuerySummary": "",
                "SourceType": "3"

        ]
        self.VM.newQuerySubmission(parameter: parameter)
    }
    
}


extension HYP_HelpVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.queryImage.image = imagePicked.resized(withPercentage: 0.5)
            self.queryImage.contentMode = .scaleAspectFit
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
