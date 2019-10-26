//
//  MovieGridDetailsViewController.swift
//  flix
//
//  Created by Samantha Eng on 10/25/19.
//  Copyright © 2019 Samantha Eng. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridDetailsViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // Set poster image
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        // Set backdrop image
        let backPath = movie["backdrop_path"] as! String
        let backUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backPath)
        backgroundView.af_setImage(withURL: backUrl!)
        
    }
    

    // MARK: - Navigation
    

    
    @IBAction func onTap(_ sender: Any) {
        print("HI")
        performSegue(withIdentifier: "showTrailer", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = movie["id"] as! Int
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let trailers = dataDictionary["results"] as! [[String:Any]]
                let key = trailers[0]["key"] as! String
                let gridTrailerViewController = segue.destination as! MovieGridTrailerViewController
                gridTrailerViewController.trailerKey = key
            }
        }
        task.resume()
    }

}
