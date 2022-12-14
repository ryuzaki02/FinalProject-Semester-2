//
//  BeerListViewController.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import UIKit

class BeerListViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var beersTableView: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cameraButton: UIButton!
    
    private lazy var viewModel = BeerListViewModel()
    private var debouncer = Debouncer(delay: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.layer.cornerRadius = 30
        
        // Setup table view and loader
        beersTableView.estimatedRowHeight = 50
        beersTableView.delegate = self
        beersTableView.dataSource = self
        showLoader(show: true)
        
        searchBar.delegate = self
        
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
    
    @IBAction func cameraButtonAction(_ sender: UIButton!) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
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
        if indexPath.row == viewModel.beers.count - 2 && viewModel.hasMoreData {
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
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IngredientsViewController") as? IngredientsViewController {
            viewController.beerModel = viewModel.beers[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

extension BeerListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.debounce { [weak self] in
            self?.showLoader(show: true)
            self?.viewModel.currentPage = 1
            self?.viewModel.searchText = searchText
            self?.getServerData()
        }
    }
}
