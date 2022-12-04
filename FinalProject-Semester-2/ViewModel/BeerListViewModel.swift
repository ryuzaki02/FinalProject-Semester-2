//
//  BeerListViewModel.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import Foundation

class BeerListViewModel {
    
    var beers: [BeerModel] = []
    var apiManager: ApiManager?
    var currentPage = 1
    var searchText = ""
    var hasMoreData = true
    
    init() {
        self.apiManager = ApiManager()
    }
    
    func getDataFromServer(completionHandler: (() -> ())?) {
        let url = "https://api.punkapi.com/v2/beers?page=\(currentPage)" + (searchText.isEmpty ? "" : "&beer_name=\(searchText)")
        apiManager?.fetch(urlString: url, completionHandler: {[weak self] dataArray in
            if let dataArray = dataArray {
                DispatchQueue.main.async {
                    DatabaseManager.shared.saveBeersToDBFor(beers: dataArray)
                }
                self?.currentPage == 1 ? self?.beers = dataArray : self?.beers.append(contentsOf: dataArray)
                self?.hasMoreData = self?.currentPage ?? 1 > 1 && dataArray.count == 0 ? false : true
            }
            completionHandler?();
        })
    }
    
}
