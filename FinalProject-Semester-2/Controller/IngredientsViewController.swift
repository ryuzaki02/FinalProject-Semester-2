//
//  IngredientsViewController.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-15.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    @IBOutlet weak var ingTableView: UITableView!
    
    var beerModel: BeerModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingTableView.estimatedRowHeight = 50
        ingTableView.delegate = self
        ingTableView.dataSource = self
        ingTableView.reloadData()
        // Do any additional setup after loading the view.
    }

}

extension IngredientsViewController:  UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Malt"
        } else if section == 2 {
            return "Hop"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return beerModel.ingredients?.malt?.count ?? 0
        } else if section == 2 {
            return beerModel.ingredients?.hops?.count ?? 0
        }
        return 0
    }
}

extension IngredientsViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngTableViewCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = beerModel.ingredients?.yeast ?? ""
        } else if indexPath.section == 1 {
            cell.textLabel?.text = beerModel.ingredients?.malt?[indexPath.row].name ?? ""
        } else if indexPath.section == 2 {
            cell.textLabel?.text = beerModel.ingredients?.hops?[indexPath.row].name ?? ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
