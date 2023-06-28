//
//  HYP_MyRedemptionVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit
import WebKit

class HYP_MyRedemptionVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate, myRedeemptionDelegate {
    func downloadVoucher(item: HYP_MyRedemptionTVCell) {
        self.downloadVoucherShadowView.isHidden =  false
        let request =  URLRequest(url: URL(string: item.pdfLink)!)
        self.voucherDetailsWebview.load(request)
        self.pdfLink = item.pdfLink
        self.pdfFileName =  item.productName
    }
    

    func didTappedResetFilterBtn(item: HYP_FilterVC) {
        fromDate = ""
        toDate = ""
        statusId = "-1"
        statusName = ""
        startIndex = 0
        noOfElement = 0
        self.VM.myRedeemptionList.removeAll()
        myRedeemptionList_Api()
    }
    func didTappedFilterBtn(item: HYP_FilterVC) {
        fromDate = item.fromDate
        toDate = item.toDate
        statusId = item.statusId
        statusName = item.statusName
        startIndex = 0
        noOfElement = 0
        self.VM.myRedeemptionList.removeAll()
        myRedeemptionList_Api()
    }

    @IBOutlet weak var voucherDetailsWebview: WKWebView!
    @IBOutlet weak var downloadVoucherShadowView: UIView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var redeemptionTableView: UITableView!
    var fromDate = ""
    var toDate = ""
    var statusName = ""
    var statusId = "-1"
    var startIndex = 1
    var noOfElement = 0
    var pdfLink = ""
    var pdfFileName = "Voucher"
    let renderer = UIPrintPageRenderer()
    var VM = HYP_MyRedemptionVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        redeemptionTableView.delegate = self
        redeemptionTableView.dataSource = self
        emptyMessage.isHidden = true
        self.redeemptionTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 80,right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.VM.myRedeemptionList.removeAll()
        self.downloadVoucherShadowView.isHidden = true
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IOS_Internet_Check") as! IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
//            internet is working
            myRedeemptionList_Api()
        }
    }
    
    @IBAction func didTappedVoucherDownloadBtn(_ sender: UIButton) {
        if pdfLink != nil && pdfLink != ""{
            convertandSavePdfToDevice(name: pdfFileName)
        }else{
            self.view.makeToast("Voucher file isn't available",duration: 2.0,position: .center)
        }
        
    }
    
    
    
    @IBAction func didTappedClosedBtn(_ sender: Any) {
        self.downloadVoucherShadowView.isHidden =  true
    }
    
    
    @IBAction func didTappedFilterBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.flags = "myRedeemption"
        vc?.fromDate = fromDate
        vc?.toDate = toDate
        vc?.statusId = statusId
        vc?.statusName = statusName
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //  MARK: - MR REDEEMPTION LIST API
        func myRedeemptionList_Api(){
            let parameter : [String : Any] =

            [
                "ActionType": 52,
                "ActorId": userId,
                "StartIndex": startIndex,
                "NoOfRows": 10,
                "ObjCatalogueDetails": [
                    "CatalogueType": 4,
                    "MerchantId": 1,
                    "JFromDate": fromDate,
                    "JToDate": toDate,
                    "RedemptionTypeId": "-1",
                    "SelectedStatus": statusId
                ],
                "Vendor":"WOGI"
            ]

            print(parameter,"myRedeemptionList_Api")
            self.VM.myRedeemptionListApi(parameter: parameter)
        }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myRedeemptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyRedemptionTVCell", for: indexPath) as! HYP_MyRedemptionTVCell
        cell.selectionStyle = .none
        var myRedeemptionData = self.VM.myRedeemptionList[indexPath.row]
        if myRedeemptionData.redemptionStatus == 4 {
            cell.downloadVoucherHeight.constant = 60
            cell.statusLbl.text = "Deliverd"
            cell.statusLbl.textColor = approvedTextColor
            cell.statusLbl.backgroundColor = approvedBgColor
            cell.downloadVoucher = myRedeemptionData.productImage ?? ""
            cell.pdfLink = myRedeemptionData.pdfLink ?? ""
        }else if myRedeemptionData.redemptionStatus == 0{
            cell.downloadVoucherHeight.constant = 0
            cell.statusLbl.text = "Pending"
            cell.statusLbl.textColor = pendingStatusColor
            cell.statusLbl.backgroundColor = pendingBGColor
        }else if myRedeemptionData.redemptionStatus == 3{
            cell.downloadVoucherHeight.constant = 0
            cell.statusLbl.text = "Cancelled"
            cell.statusLbl.textColor = cancelTextColor
            cell.statusLbl.backgroundColor = cancelBgColor
        }
        cell.pointsLbl.text = "\(Int(myRedeemptionData.redemptionPoints ?? 0) ) \("points")"
        let redeemptionDate = myRedeemptionData.jRedemptionDate?.split(separator: " ")
        cell.dateLbl.text = String(redeemptionDate?[0] ?? "-")
        cell.voucherNameLbl.text = myRedeemptionData.productName ?? "-"
        cell.productName = myRedeemptionData.productName ?? "-"
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == redeemptionTableView{
            if indexPath.row != (self.VM.myRedeemptionList.count - 1){
                if noOfElement == 10{
                    startIndex += 1
                    myRedeemptionList_Api()
                }else if noOfElement > 10{
                    startIndex += 1
                    myRedeemptionList_Api()
                }else if noOfElement < 10{
                    print("no need to reload")
                    return
                }else{
                    print("no more data available")
                    return
                }
            }
        }
    }
    
    
    func convertandSavePdfToDevice(name: String) {
        self.startLoading()
                //create print formatter object
                let printFormatter = voucherDetailsWebview.viewPrintFormatter()
                // create renderer which renders the print formatter's content on pages
                let renderer = UIPrintPageRenderer()
                renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)

                // Specify page sizes
                let pageSize = CGSize(width: 595.2, height: 841.8) //set desired sizes

                // Page margines
                let margin = CGFloat(20.0)

                // Set page sizes and margins to the renderer
                renderer.setValue(NSValue(cgRect: CGRect(x: margin, y: margin, width: pageSize.width, height: pageSize.height - margin * 2.0)), forKey: "paperRect")
                renderer.setValue(NSValue(cgRect: CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)), forKey: "printableRect")

                // Create data object to store pdf data
                let pdfData = NSMutableData()
                // Start a pdf graphics context. This makes it the current drawing context and every drawing command after is captured and turned to pdf data
                UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)

                // Loop through number of pages the renderer says it has and on each iteration it starts a new pdf page
                for i in 0..<renderer.numberOfPages {
                     UIGraphicsBeginPDFPage()
                // draw content of the page
                     renderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
                }
                // Close pdf graphics context
                UIGraphicsEndPDFContext()
                
                
                let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(name).pdf")
                try? pdfData.write(to: filePath, options: .atomic)
                let activityViewController = UIActivityViewController(activityItems: [filePath], applicationActivities: [])
        self.stopLoading()
                present(activityViewController, animated: true, completion: nil)
            }
}
