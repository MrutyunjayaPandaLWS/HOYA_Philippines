//
//  HYP_MyEarningVC.swift
//  Hoya Phillippines
//
//  Created by syed on 17/02/23.
//

import UIKit

class HYP_MyEarningVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterProtocolDelegate {
    func didTappedFilterBtn(item: HYP_FilterVC) {}
    

    @IBOutlet weak var myEarnigTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myEarnigTableView.register(UINib(nibName: "HYP_MyEarningTVCell", bundle: nil), forCellReuseIdentifier: "HYP_MyEarningTVCell")
        myEarnigTableView.delegate = self
        myEarnigTableView.dataSource = self
       

    }
    
    @IBAction func didTappedFilterBtn(_ sender: UIButton) {
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyEarningTVCell", for: indexPath) as! HYP_MyEarningTVCell
        cell.selectionStyle = .none
        return cell
    }

}
