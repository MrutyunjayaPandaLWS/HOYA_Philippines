//
//  KC_DropDownVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/02/2023.
//

import UIKit


@objc protocol SearchableDropDownDelegate: AnyObject{
   @objc optional func selectedProductName(item: SelectDealerDropDownVC)

}


class SelectDealerDropDownVC: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dropDownTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    var selectedStatusName = ""
    var selectedStatusID = ""
    var VM = SearchableDropDownVM()
    var delegate: SearchableDropDownDelegate?
    var progrmaId = 0
    var rowNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.searchBar.delegate = self
        self.noDataFoundLbl.isHidden = true
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        self.noDataFoundLbl.isHidden = true
        getProductList_Api()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.view {
            self.dismiss(animated: true, completion: nil)
            self.searchBar.resignFirstResponder()
        } else {
            self.searchBar.resignFirstResponder()
        }
    }
    override func viewWillLayoutSubviews() {
        
    }
    
    @IBAction func selectCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
  
    func getProductList_Api(){
        let parameter : [String : Any] = [
                "ActorId":userId,
                 "SearchText": "",
                "LoyaltyProgramId":progrmaId ?? 0,
                "ProductDetails":[
                    "ActionType": 20
                ]
        ]
        print(parameter,"product list")
        self.VM.productListApi(parameter: parameter)
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            if self.VM.promotionProductList.count > 0 {
                let arr = self.VM.promotionProductList1.filter{ ($0.productName!.localizedCaseInsensitiveContains(searchBar.text!))}
                if self.searchBar.text != ""{
                    if arr.count > 0 {
                        self.VM.promotionProductList.removeAll(keepingCapacity: true)
                        self.VM.promotionProductList = arr
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = false
                    }else {
                        self.VM.promotionProductList = self.VM.promotionProductList1
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = true
                    }
                }else{
                    self.VM.promotionProductList = self.VM.promotionProductList1
                    self.dropDownTableView.reloadData()
                    dropDownTableView.isHidden = false
                }
                let searchText = searchBar.text!
                if searchText.count > 0 || self.VM.promotionProductList1.count == self.VM.promotionProductList.count {
                    self.dropDownTableView.reloadData()
                }
            }
        }

}
extension SelectDealerDropDownVC: UITableViewDelegate, UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.VM.promotionProductList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDealerDropDownTVC", for: indexPath) as! SelectDealerDropDownTVC
        cell.selectedTitleLbl.text = self.VM.promotionProductList[indexPath.row].productName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedStatusName = self.VM.promotionProductList[indexPath.row].productName ?? ""
        self.selectedStatusID = self.VM.promotionProductList[indexPath.row].productCode ?? ""
        self.delegate?.selectedProductName?(item: self)
        self.dismiss(animated: true, completion: nil)
    }

    
}



