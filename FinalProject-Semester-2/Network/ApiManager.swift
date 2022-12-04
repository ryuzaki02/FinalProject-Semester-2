//
//  ApiManager.swift
//  FinalProject-Semester-2
//
//  Created by Aman Thakur on 2022-12-03.
//

import Foundation

struct ApiManager {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetch(urlString: String = "") {
        guard
            let url = URL(string: urlString)
        else{
            preconditionFailure("was not able to convert string to url: \(urlString)")
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode([BeerModel].self, from: data)
                    print(decoded)
                } catch {
                    print("Failed to decode JSON")
                }
            } else if let error = error {
                print("error with data task: \(error)")
            } else {
                print("something went wrong: \(String(describing: response))")
            }
        }
        task.resume()
    }
}
