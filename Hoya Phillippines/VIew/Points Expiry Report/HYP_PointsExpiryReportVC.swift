//
//  HYP_PointsExpiryReportVC.swift
//  Hoya Phillippines
//
//  Created by syed on 03/03/23.
//

import UIKit

class HYP_PointsExpiryReportVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {
        
    }
    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var pointExpireReportTV: UITableView!
    @IBOutlet weak var totalPointsLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        pointExpireReportTV.delegate = self
        pointExpireReportTV.dataSource = self
        drawDottedLine(start: CGPoint(x: lineView1.bounds.minX, y: lineView1.bounds.minY), end: CGPoint(x: lineView1.bounds.maxX, y: lineView1.bounds.minY), view: lineView1)
        drawDottedLine(start: CGPoint(x: lineView2.bounds.minX, y: lineView2.bounds.minY), end: CGPoint(x: lineView2.bounds.maxX, y: lineView2.bounds.minY), view: lineView2)
    }
    
    
    @IBAction func selectFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HYP_FilterVC") as? HYP_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.flags = ""
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeight.constant = CGFloat(6*40)
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_PointsExpiryReportTVCell", for: indexPath) as! HYP_PointsExpiryReportTVCell
        drawDottedLine(start: CGPoint(x: cell.lineView3.bounds.minX, y: cell.lineView3.bounds.minY), end: CGPoint(x: cell.lineView3.bounds.maxX, y: cell.lineView3.bounds.minY), view: cell.lineView3)
        cell.expireDateLbl.text = "02/03/2023"
        cell.pointsExpireLbl.text = "88"
        if indexPath.row == 0{
            cell.lineView3.isHidden = true
        }else{
            cell.lineView3.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
