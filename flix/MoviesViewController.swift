//
//  MoviesViewController.swift
//  flix
//
//  Created by Samantha Eng on 10/16/19.
//  Copyright © 2019 Samantha Eng. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Properties
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveInfo()
    }
    

    // MARK: - Priavte Function
    func retrieveInfo() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // TODO: Get the array of movies
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data

            }
        }
        task.resume()
    }
    
    
}
