//
//  BeerListViewController.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import UIKit

class BeerListViewController: UIViewController {
    
    @IBOutlet weak var beersTableView: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    private lazy var viewModel = BeerListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup table view and loader
        beersTableView.estimatedRowHeight = 50
        beersTableView.delegate = self
        beersTableView.dataSource = self
        showLoader(show: true)
        
        
        // Calls method to get data from server
        viewModel.currentPage = 1
        getServerData()
    }
    
    // MARK: - Methods
    
    // Method to show/hide load and table view and reload it
    // param: show - Bool
    // return: nothing
    private func showLoader(show: Bool) {
        // Updated UI of main thread
        DispatchQueue.main.async { [weak self] in
            self?.beersTableView.reloadData()
            show ? self?.loaderView.startAnimating() : self?.loaderView.stopAnimating()
            self?.loaderView.isHidden = !show
            self?.beersTableView.isHidden = show
        }
    }
    
    private func getServerData() {
        viewModel.getDataFromServer { [weak self] in
            self?.showLoader(show: false)
        }
    }

}

extension BeerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.beers[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.beers.count - 2 {
            viewModel.currentPage += 1
            getServerData()
        }
    }
}

extension BeerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreedImageViewController") as? BreedImageViewController {
//            viewController.breedModel = breedsArray[indexPath.row]
//            navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    
}
