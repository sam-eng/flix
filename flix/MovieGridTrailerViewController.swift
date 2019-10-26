//
//  MovieGridTrailerViewController.swift
//  flix
//
//  Created by Samantha Eng on 10/25/19.
//  Copyright © 2019 Samantha Eng. All rights reserved.
//

import UIKit
import WebKit

class MovieGridTrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    var trailerKey : String!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
