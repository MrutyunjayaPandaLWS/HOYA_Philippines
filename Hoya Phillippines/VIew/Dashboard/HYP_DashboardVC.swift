//
//  HYP_DashboardVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import Lottie
import AVFoundation
import Photos
import ImageSlideshow
import SDWebImage

class HYP_DashboardVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, popMessage2Delegate{
    func didTappedOKBtn(item: SuccessMessage2) {
        if item.flags == "1"{
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            if #available(iOS 13.0, *){
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            }else{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }
    }
     func successMessage3(item: HYP_SuccessMessageVC) {
        if item.itsComeFrom == "1"{
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            if #available(iOS 13.0, *){
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            }else{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }

        }
    }

    @IBOutlet weak var offersSlideShow: ImageSlideshow!
    @IBOutlet weak var bottomViewTopConstraints: NSLayoutConstraint!
//    @IBOutlet weak var clmaimViewTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var mystaffview: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var claimView: UIView!
    @IBOutlet weak var claimViewHeight: NSLayoutConstraint!
    @IBOutlet weak var storeOwnerMenuListView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var storeOwnerMenuListCollectionViewCell: UICollectionView!
    @IBOutlet weak var individualMenuListView: UIView!
    @IBOutlet weak var membershipIdLbl: UILabel!
    @IBOutlet weak var roleNameLbl: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var giftAnimation: LottieAnimationView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var menuListTableView: UITableView!
    var individualLoginStatus = UserDefaults.standard.integer(forKey: "Individual")
    
    var backgroundColor  = #colorLiteral(red: 0, green: 0.3333333333, blue: 0.768627451, alpha: 1)
    var individualTableCellHeight = 0.0
    
    var menuList : [MenuListModel] = [MenuListModel(menuName: "Claim Status", menuIcon: "refund"),
                                      MenuListModel(menuName: "My Earning", menuIcon: "balance_wallet_payment_cash"),
                                      MenuListModel(menuName: "My Redemption", menuIcon: "Group 475")
//                                      MenuListModel(menuName: "Points Expiry Report", menuIcon: "Group 8196")
    ]
    
    var menuList2 : [MenuListModel] = [
                                      MenuListModel(menuName: "My Earning", menuIcon: "balance_wallet_payment_cash"),
                                      MenuListModel(menuName: "My Redemption", menuIcon: "Group 475")
    ]
    
    var strdata1 = ""
    let imagePicker = UIImagePickerController()
    var VM = HYP_DashboardVM()
    var sourceArray = [AlamofireSource]()
    var sourceArray1 = [SDWebImageSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        menuListTableView.delegate = self
        menuListTableView.dataSource = self
        
        lottieAnimation(animationView: giftAnimation)
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        
        storeOwnerMenuListCollectionViewCell.delegate = self
        storeOwnerMenuListCollectionViewCell.dataSource = self
        storeOwnerMenuListCollectionViewCell.register(UINib(nibName: "HYP_StoreOwnerMenuListCVCell", bundle: nil), forCellWithReuseIdentifier: "HYP_StoreOwnerMenuListCVCell")
//        collectionViewHeight.constant = 72
        individualMenuListView.isHidden = true
        if customerTypeID != 1{
            individualMenuListView.isHidden = false
            storeOwnerMenuListView.isHidden = true
            claimView.isHidden = false
            mystaffview.isHidden = true
//            bottomViewTopConstraints.constant = 88
            backgroundView.backgroundColor = .white
        }else{
            individualMenuListView.isHidden = true
//            claimViewHeight.constant = 0
            claimView.isHidden = true
            mystaffview.isHidden = false
            backgroundView.backgroundColor = backgroundColor
//            bottomViewTopConstraints.constant = 0
//            clmaimViewTopConstraints.constant = -50
            storeOwnerMenuListView.isHidden = false
        }
        imagePicker.delegate = self
//        dashboardOffersApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            tokendata()
            if sourceArray.count  == 0{
                dashboardOffersApi()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        claimViewHeight.constant = 0
    }
    
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as? HistoryNotificationsViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func didTappedLogoutBtn(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessMessage2") as? SuccessMessage2
        vc!.delegate = self
        vc!.message = "Are you sure you want to Logout ?"
        vc?.btnName = "Logout"
        vc?.vcTitle = "Logout"
        vc!.flags = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
        
        
        
        
//        UserDefaults.standard.set(false, forKey: "UserLoginStatus")
//        if #available(iOS 13.0, *) {
//            let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
//            sceneDelegate.setInitialViewAsRootViewController()
//        } else {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.setInitialViewAsRootViewController()
//        }
        
    }
    @IBAction func didTappedManageStaffBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_MyStaffVC") as? HYP_MyStaffVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func didTappedClaimBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_ProgramListVC") as? HYP_ProgramListVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedRedeemBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_VouchersVC") as? HYP_VouchersVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedPointExpireReport(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_PointsExpiryReportVC") as? HYP_PointsExpiryReportVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func didTappedProfileBtn(_ sender: UIButton) {
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
    
    
    func profileImageUpdateAPI(){
        let parameter : [String : Any] = [
            
                "ActorId": userId,
                "ObjCustomerJson": [
                    "DisplayImage": strdata1,
                    "LoyaltyId": loyaltyId
                ]
        ]
        self.VM.profileaImageUpdateApi(parameter: parameter)
        
    }
    
    func dashboardApi(){
        let parameter : [String : Any] = [
                "ActorId": userId
        ]
        self.VM.dashBoardApi(parameter: parameter, completion: {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_SuccessMessageVC") as? HYP_SuccessMessageVC
            vc!.delegate = self
            vc!.successMessage = "Your account is deactivate please contact to your administrator"
            vc!.itsComeFrom = "1"
            vc?.imageStatus = true
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        })
    }
    
    
    func dashboardOffersApi(){
        let parameter : [String : Any] = [
            "ActionType": 99,
            "ActorId": userId,
            "PromotionUserType": "HOYA"
        ]
        self.VM.dashbaordOffers(parameter: parameter)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
//    MARK: - INDIVIDUAL MENULIST TABLE VIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MenuListTVCell", for: indexPath) as! HYP_MenuListTVCell
        if indexPath.row == 0{
            cell.lineLbl.isHidden = true
        }else{
            cell.lineLbl.isHidden = false
        }
        cell.selectionStyle = .none
        cell.menuName.text = menuList[indexPath.row].menuName
        cell.menuIcon.image = UIImage(named: menuList[indexPath.row].menuIcon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print((menuListTableView.bounds.size.height)/Double(menuList.count),"tableview")
        return (menuListTableView.bounds.size.height)/Double(menuList.count)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuList[indexPath.row].menuName{
        case "Claim Status":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_ClaimsStatusVC") as? HYP_ClaimsStatusVC
            navigationController?.pushViewController(vc!, animated: true)
        case "My Earning":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_MyEarningVC") as? HYP_MyEarningVC
            navigationController?.pushViewController(vc!, animated: true)
        case "My Redemption":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_MyRedemptionVC") as? HYP_MyRedemptionVC
            navigationController?.pushViewController(vc!, animated: true)
        case "Points Expiry Report":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_PointsExpiryReportVC") as? HYP_PointsExpiryReportVC
            navigationController?.pushViewController(vc!, animated: true)
        default:
            print("")
        }
    }
}

extension HYP_DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //    MARK: - STORE OWNER MENULIST COLLECTION VIEW
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return menuList2.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HYP_StoreOwnerMenuListCVCell", for: indexPath) as! HYP_StoreOwnerMenuListCVCell
            cell.menuIcon.image = UIImage(named: menuList2[indexPath.row].menuIcon)
                cell.menuNameLbl.text = menuList2[indexPath.row].menuName
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.storeOwnerMenuListCollectionViewCell.bounds.size.height,"collectionView")
        return CGSize(width: (storeOwnerMenuListCollectionViewCell.frame.size.width - 20 - (self.storeOwnerMenuListCollectionViewCell.contentInset.left + self.storeOwnerMenuListCollectionViewCell.contentInset.right)) / 2.0, height: self.storeOwnerMenuListCollectionViewCell.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch menuList2[indexPath.row].menuName{
        case "Claim Status":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_ClaimsStatusVC") as? HYP_ClaimsStatusVC
            navigationController?.pushViewController(vc!, animated: true)
        case "My Earning":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_MyEarningVC") as? HYP_MyEarningVC
            navigationController?.pushViewController(vc!, animated: true)
        case "My Redemption":
            let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_MyRedemptionVC") as? HYP_MyRedemptionVC
            navigationController?.pushViewController(vc!, animated: true)
        default:
            print("")
        }
    }
    
    
}

extension HYP_DashboardVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = imagePicked.resized(withPercentage: 0.5)
            profileImage.contentMode = .scaleToFill
            let imageData = imagePicked.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            profileImageUpdateAPI()
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
                        self.imagePicker.mediaTypes = ["public.image"]
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


extension HYP_DashboardVC{
    
    func ImageSetups1(){
        self.sourceArray1.removeAll()
        if self.VM.dashboardOffers.count > 0 {
            DispatchQueue.main.async { [self] in
                for image in self.self.VM.dashboardOffers {
                    print("\(PROMO_IMG1)\(image.proImage ?? ""), offerImgUrl")
                    let imageURL = image.proImage ?? ""
                    let filteredURLArray = imageURL.dropFirst(3)
                    let replaceString = "\(PROMO_IMG1)\(filteredURLArray)".replacingOccurrences(of: " ", with: "%20")
                    self.sourceArray1.append(SDWebImageSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img (1)"))!)
                    //                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img (1)"))!)
                }
                offersSlideShow.setImageInputs(self.sourceArray1)
                offersSlideShow.slideshowInterval = 3.0
                offersSlideShow.zoomEnabled = true
                offersSlideShow.contentScaleMode = .scaleToFill
                offersSlideShow.pageControl.currentPageIndicatorTintColor = UIColor(red: 230/255, green: 27/255, blue: 34/255, alpha: 1)
                offersSlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
            }
        }else{
            offersSlideShow.contentScaleMode = .scaleToFill
            offersSlideShow.setImageInputs([ImageSource(image: UIImage(named: "ic_default_img (1)")!)])
        }
    }
//
    func ImageSetups(){
        self.sourceArray.removeAll()
        if self.VM.dashboardOffers.count > 0 {
            for image in self.self.VM.dashboardOffers {
                print("\(PROMO_IMG1)\(image.proImage ?? ""), offerImgUrl")
                let imageURL = image.proImage ?? ""
                let filteredURLArray = imageURL.dropFirst(3)
                let replaceString = "\(PROMO_IMG1)\(filteredURLArray)".replacingOccurrences(of: " ", with: "%20")
                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img (1)"))!)
            }
            offersSlideShow.setImageInputs(self.sourceArray)
            offersSlideShow.slideshowInterval = 3.0
            offersSlideShow.zoomEnabled = true
            offersSlideShow.contentScaleMode = .scaleToFill
            offersSlideShow.pageControl.currentPageIndicatorTintColor = UIColor(red: 230/255, green: 27/255, blue: 34/255, alpha: 1)
            offersSlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        }else{
            offersSlideShow.contentScaleMode = .scaleToFill
            offersSlideShow.setImageInputs([ImageSource(image: UIImage(named: "ic_default_img (1)")!)])
        }
    }
    
    
    
    @objc func didTap() {
        if self.VM.dashboardOffers.count > 0 {
             self.tabBarController?.selectedIndex = 1
        }
    }
    
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    DispatchQueue.main.async {
                        self.dashboardApi()
                        
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
}





struct MenuListModel{
    let menuName: String
    let menuIcon: String
}
