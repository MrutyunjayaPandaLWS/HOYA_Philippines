import UIKit
import NotificationCenter
import Photos
import AVFoundation
import SDWebImage
import Toast_Swift
//import LanguageManager_iOS

class HR_Chatvc2ViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate{
    
    @IBOutlet weak var ticketDetailsHeight: NSLayoutConstraint!
    @IBOutlet var supportHeadingLabel: UILabel!
    @IBOutlet weak var textfieldview: UIView!
    @IBOutlet weak var querySummarylabel: UILabel!
    @IBOutlet weak var commenttextfield: UITextField!
    @IBOutlet weak var sendbutton: UIButton!
    @IBOutlet var tableview12: UITableView!
    @IBOutlet weak var expandedview: UIView!
    @IBOutlet weak var expandedimageview: UIImageView!
    
    var CustomerTicketIDchatvc = 0
    let userID = UserDefaults.standard.value(forKey: "userId") ?? ""
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var helptopicdetails = ""
    var helptopicid = -1
    var helptopicName = ""
    var querysummary = ""
    var querydetails = ""
//    var requestAPIs = RestAPI_Requests()
    let reachability = Reach()
    let picker = UIImagePickerController()
    var FileType = ""
    var strBase64 = ""
//    var chatlistingArray = [ObjQueryResponseJsonList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketDetailsHeight.constant = 0
        self.supportHeadingLabel.text = "Support"
        self.querySummarylabel.text = "Ticket Details"
        tableview12.register(UINib(nibName: "senderInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "senderInfoTableViewCell")
        tableview12.register(UINib(nibName: "otherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "otherInfoTableViewCell")
        tableview12.register(UINib(nibName: "senderImageTableViewCell", bundle: nil), forCellReuseIdentifier: "senderImageTableViewCell")
        tableview12.register(UINib(nibName: "otherImageTableViewCell", bundle: nil), forCellReuseIdentifier: "otherImageTableViewCell")
        tableview12.register(UINib(nibName: "senderInfoImageTableViewCell", bundle: nil), forCellReuseIdentifier: "senderInfoImageTableViewCell")
        tableview12.register(UINib(nibName: "otherInfoImageTableViewCell", bundle: nil), forCellReuseIdentifier: "otherInfoImageTableViewCell")
        print(CustomerTicketIDchatvc)
        self.commenttextfield.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification1012(notification:)), name: Notification.Name("NotificationIdentifierinternet"), object: nil)
        picker.delegate = self
        tableview12?.delegate = self
        tableview12?.dataSource = self
        print(CustomerTicketIDchatvc)
//        if reachability.connectionStatus() == .offline {
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "NoInternet".localiz()
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        } else {
            chatListingAPI()
//        }
        querySummarylabel.text = "\("Query summary") : \(querysummary)"
        self.supportHeadingLabel.text = "Support"
        self.commenttextfield.placeholder = "\("Write Query Here")..."

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//chatlistingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let verifyusertype = self.chatlistingArray[indexPath.row].userType ?? ""
//        print(verifyusertype, "Customer TYpe")
//        print(self.chatlistingArray[indexPath.item].imageUrl ?? "", "Image URL")
//        print(self.chatlistingArray[indexPath.row].queryResponseInfo ?? "", "ResponseText")
//        if verifyusertype == "Customer" || verifyusertype == "CUSTOMER"{
//            if self.chatlistingArray[indexPath.row].queryResponseInfo != nil  && self.chatlistingArray[indexPath.row].imageUrl == nil ||  self.chatlistingArray[indexPath.row].queryResponseInfo != ""  && self.chatlistingArray[indexPath.row].imageUrl == "" {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "senderInfoTableViewCell") as? senderInfoTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].jCreatedDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                cell?.itemText.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                cell?.layoutIfNeeded()
//                print(cell?.frame.height)
//                print(cell?.itemText.frame.height)
//
//                return cell!
//            }else if self.chatlistingArray[indexPath.row].queryResponseInfo == nil  && self.chatlistingArray[indexPath.row].imageUrl != nil || self.chatlistingArray[indexPath.row].queryResponseInfo == ""  && self.chatlistingArray[indexPath.row].imageUrl != ""{
//                print("Imageasdfasdfs")
//                let cell = tableView.dequeueReusableCell(withIdentifier: "senderImageTableViewCell") as? senderImageTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].jCreatedDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                var secondaryIMG = (self.chatlistingArray[indexPath.item].imageUrl ?? "").dropFirst(2)
//                let splited = secondaryIMG
//                print("\(PROMO_IMG1)\(splited)")
//                cell?.itemimage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(splited)"), placeholderImage: UIImage(named: "default"))
//                return cell!
//            }else if self.chatlistingArray[indexPath.row].queryResponseInfo != nil  && self.chatlistingArray[indexPath.row].imageUrl != nil || self.chatlistingArray[indexPath.row].queryResponseInfo != ""  && self.chatlistingArray[indexPath.row].imageUrl != ""{
//                print("Check Again")
//                let cell = tableView.dequeueReusableCell(withIdentifier: "otherInfoImageTableViewCell") as? otherInfoImageTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].jCreatedDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                cell?.itemtext.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                var secondaryIMG = self.chatlistingArray[indexPath.item].imageUrl ?? ""
//                let splited = secondaryIMG.dropFirst(2)
//                cell?.itemimage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(splited)"), placeholderImage: UIImage(named: "default"))
//                return cell!
//            }else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "senderInfoTableViewCell") as? senderInfoTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].jCreatedDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                cell?.itemText.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                return cell!
//            }
//        }else if verifyusertype == "Merchant" || verifyusertype == "SuperAdmin" || verifyusertype == "User" || verifyusertype == "Location" || verifyusertype == "" {
//            if self.chatlistingArray[indexPath.row].queryResponseInfo != nil  && self.chatlistingArray[indexPath.row].imageUrl == nil{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "otherInfoTableViewCell") as? otherInfoTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].createdDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                cell?.itemText.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                return cell!
//            }else if self.chatlistingArray[indexPath.row].queryResponseInfo != nil  && self.chatlistingArray[indexPath.row].imageUrl != nil{
                let cell = tableView.dequeueReusableCell(withIdentifier: "senderInfoImageTableViewCell") as? senderInfoImageTableViewCell
                cell?.itemTime.text = "12:32:18"//self.chatlistingArray[indexPath.row].createdDate ?? ""
                cell?.itemcustomer.text = "testing"//self.chatlistingArray[indexPath.row].repliedBy ?? ""
                cell?.itemtext.text = "testing-1" //self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                var secondaryIMG = self.chatlistingArray[indexPath.item].imageUrl ?? ""
//                let splited = secondaryIMG.components(separatedBy: "~")
//                cell?.itemimage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(splited[1])"), placeholderImage: UIImage(named: "default"))
                return cell!
//            }else if self.chatlistingArray[indexPath.row].queryResponseInfo == nil  && self.chatlistingArray[indexPath.row].imageUrl != nil{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "otherImageTableViewCell") as? otherImageTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].createdDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                var secondaryIMG = self.chatlistingArray[indexPath.item].imageUrl ?? ""
//                let splited = secondaryIMG.components(separatedBy: "~")
//                cell?.itemimage.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(splited[1])"), placeholderImage: UIImage(named: "default"))
//                return cell!
//            }else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "otherInfoTableViewCell") as? otherInfoTableViewCell
//                cell?.itemTime.text = self.chatlistingArray[indexPath.row].jCreatedDate ?? ""
//                cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//                cell?.itemText.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//                return cell!
//            }
//
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "otherInfoTableViewCell") as? otherInfoTableViewCell
//            cell?.itemTime.text = convertDateFormater(self.chatlistingArray[indexPath.row].jCreatedDate ?? "")
//            cell?.itemcustomer.text = self.chatlistingArray[indexPath.row].repliedBy ?? ""
//            cell?.itemText.text = self.chatlistingArray[indexPath.row].queryResponseInfo ?? ""
//            return cell!
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(self.chatlistingArray[indexPath.item].imageUrl ?? "0", "Image URL")
//        if self.chatlistingArray[indexPath.item].imageUrl != nil{
//            let secondaryIMG = String(self.chatlistingArray[indexPath.item].imageUrl ?? "").dropFirst(2)
//            let splited = secondaryIMG
//            print("\(PROMO_IMG1)\(splited)")
//            expandedimageview.sd_setImage(with: URL(string: "\(PROMO_IMG1)\(splited)"), placeholderImage: UIImage(named: "d2.jpg"))
//            expandedview.isHidden = false
//            return
//        }else{
//            return
//        }
//    }
    
    @IBAction func closeexpandedview(_ sender: Any) {
        expandedview.isHidden = true
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        commenttextfield.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func attachmentButton(_ sender: Any) {
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func chatListingAPI(){
        self.commenttextfield.text = ""
//        self.chatlistingArray.removeAll()
//        startLoading()
        let parameterJSON = [
            "ActionType":"171",
            "ActorId":"\(userID)",
            "CustomerTicketID":"\(CustomerTicketIDchatvc)"
            
        ] as [String:Any]
        print(parameterJSON)
//        self.requestAPIs.chatQuery_Post_API(parameters: parameterJSON) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.chatlistingArray = (result?.objQueryResponseJsonList)!
////                        self.tableview12.reloadData()
//                        if self.chatlistingArray.count != 0{
//                            self.tableview12.reloadData()
//                            self.scrollToBottom()
//                        }
//                        self.stopLoading()
//                    }
//                }else{
//                    print("NO RESPONSE")
//                    DispatchQueue.main.async {
//                        self.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//
//            }
//        }
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
//            let indexPath = IndexPath(row:  self.chatlistingArray.count-1, section: 0)
//            self.tableview12.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func submitHelptopic(parameters:JSON){
//        self.startLoading()
//        self.requestAPIs.newQueryTicket_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        let response = result?.returnMessage ?? "-1~failed~QE13"
//                        let responsearray = response.split(separator: "~")
//                        if responsearray[0] == "-1"{
//                            let alertController = UIAlertController(title: "", message: "Submission Failed", preferredStyle: .alert)
//                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                                UIAlertAction in
//                                self.navigationController?.popViewController(animated: true)
//                            }
//                            alertController.addAction(okAction)
//                            // Present the controller
//                            self.present(alertController, animated: true, completion: nil)
//                        }else{
//                            self.chatListingAPI()
//                        }
//                        self.stopLoading()
//                    }
//                }else{
//                    print("NO RESPONSE")
//                    DispatchQueue.main.async {
//                        self.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//
//            }
//        }
    }
    
    @IBAction func notificationbutton(_ sender: Any) {
    }
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendbutton(_ sender: Any) {
        if commenttextfield.text == ""{
            self.alertVC(title: "", message: "Enter_Comment")
        }else{
       //     if reachability.connectionStatus() == .offline {
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "NoInternet".localiz()
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
         //   } else {
//            startLoading()
            let parameterJSON = [
                "ActionType":"4",
                "ActorId":"\(userID)",
                "CustomerTicketID":"\(CustomerTicketIDchatvc)",
                "HelpTopic":"\(helptopicName)",
                "HelpTopicID":"\(helptopicid)",
                "IsQueryFromMobile":false,
                "QueryDetails":"\(commenttextfield.text ?? "")",
                "QueryStatus":"1",
                
            ] as! [String:Any]
            print(parameterJSON)
            self.submitHelptopic(parameters: parameterJSON)
            }
        //}
    }
    @objc func methodOfReceivedNotification1012(notification: Notification) {
        stopLoading()
    }
    
    func startLoading(){
        self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.color = UIColor.black
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        view.isUserInteractionEnabled = false
    }
   
    func stopLoading(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating();
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func alertVC(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


extension HR_Chatvc2ViewController{
    func openGallery() {
        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .photoLibrary
                        self.picker.mediaTypes = ["public.image"]
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Hoya Thailand need to access Gallery", message: "Allow Gallery access", preferredStyle: .alert)
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
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                self.picker.allowsEditing = false
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "Hoya Thailand need to access camera", message: "Allow Camera Access", preferredStyle: .alert)
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
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
                }
        }
    }
    
    
    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Hoya Thailand need to access camera", message: "Allow Camera Access", preferredStyle: .alert)
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
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        self.FileType = "JPG"
        let imageData = selectedImage.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
        
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "NoInternet".localiz()
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
        }else{
        profileupdaterequest()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func profileupdaterequest(){
//        startLoading()
        let parameterJSON = [
                "ActionType": "4",
                "FileType": "\(FileType)",
                "ImageUrl": "\(strBase64)",
                "ActorId": "\(userID)",
                "CustomerTicketID": "\(CustomerTicketIDchatvc)",
                "HelpTopic": "\(helptopicName)",
                "HelpTopicID": "\(helptopicid)",
                "IsQueryFromMobile": true,
                "QueryStatus": "1"
        ] as! [String:Any]
//         print(parameterJSON)
//        self.requestAPIs.newQueryTicket_API(parameters: parameterJSON) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        let response = result?.returnMessage ?? ""
//                        print(response)
//                        let responsearray = response.split(separator: "~")
//                        if responsearray.count != 0{
//                        if responsearray[0] == "-1"{
//                            let alertController = UIAlertController(title: "", message: "ImageSubmissionFailed", preferredStyle: .alert)
//                            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
//                                UIAlertAction in
//                                self.navigationController?.popViewController(animated: true)
//                            }
//                            alertController.addAction(okAction)
//                            // Present the controller
//                            self.present(alertController, animated: true, completion: nil)
//                        }else{
//                            self.chatListingAPI()
//                            
//                        }
//                        }else{
//                            let alertController = UIAlertController(title: "", message: "ImageSubmissionFailed", preferredStyle: .alert)
//                            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
//                                UIAlertAction in
//                                self.navigationController?.popViewController(animated: true)
//                            }
//                            alertController.addAction(okAction)
//                            // Present the controller
//                            self.present(alertController, animated: true, completion: nil)
//                        }
//                        self.stopLoading()
//                    }
//                }else{
//                    print("NO RESPONSE")
//                    DispatchQueue.main.async {
//                        self.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//                
//            }
//        }
    }
    
    func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss a"
            return  dateFormatter.string(from: date!)

        }
}

