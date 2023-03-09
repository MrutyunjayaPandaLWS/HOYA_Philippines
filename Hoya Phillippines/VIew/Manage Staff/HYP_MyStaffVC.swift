//
//  HYP_MyStaffVC.swift
//  Hoya Phillippines
//
//  Created by syed on 21/02/23.
//

import UIKit

class HYP_MyStaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var myStaffListTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myStaffListTableview.delegate = self
        myStaffListTableview.dataSource = self
        
        
    }
    
    @IBAction func didTappedNotificationBtn(_ sender: UIButton) {
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYP_MyStaffTVCell", for: indexPath) as! HYP_MyStaffTVCell
        cell.selectionStyle = .none
        
        return cell
    }
    
}
