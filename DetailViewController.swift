//
//  DetailViewController.swift
//  NewsReader_Day6
//
//  Created by 田中陽子 on 2019/10/08.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var link :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.link){
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
}
