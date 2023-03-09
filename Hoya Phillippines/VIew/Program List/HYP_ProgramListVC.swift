//
//  HYP_ProgramListVC.swift
//  Hoya Phillippines
//
//  Created by syed on 20/02/23.
//

import UIKit

class HYP_ProgramListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var programListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        programListTableView.delegate  = self
        programListTableView.dataSource = self

        
    }
    

    @IBAction func didTappedNotificationbtn(_ sender: UIButton) {
    }
    
    @IBAction func didtappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_ProgramListTVCell", for: indexPath) as! HYP_ProgramListTVCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HYP_ClaimDetailsVC") as? HYP_ClaimDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
}
