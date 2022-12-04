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
    
    init() {
        self.apiManager = ApiManager()
    }
    
    func getDataFromServer(completionHandler: (() -> ())?) {        
        apiManager?.fetch(urlString: "https://api.punkapi.com/v2/beers?page=\(currentPage)", completionHandler: {[weak self] dataArray in
            if let dataArray = dataArray {
                self?.currentPage == 1 ? self?.beers = dataArray : self?.beers.append(contentsOf: dataArray)
            }
            completionHandler?();
        })
    }
    
}
