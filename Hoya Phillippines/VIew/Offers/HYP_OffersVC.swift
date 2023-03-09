//
//  HYP_OffersVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_OffersVC: UIViewController, UITableViewDelegate, UITableViewDataSource,OffersDelegate{


    @IBOutlet weak var backBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var offersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        offersTableView.delegate = self
        offersTableView.dataSource = self
        backBtnWidth.constant = 0 // 22
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
    }
    
    func didTappedViewBtn(item: HYP_OffersTVcell) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_OffersDetailsVC") as? HYP_OffersDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_OffersTVcell", for: indexPath) as! HYP_OffersTVcell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}
