//
//  WebViewController.swift
//  UITableViewControllerDemo
//
//  Created by LiuScott on 15-4-3.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class WebViewController : UIViewController {
    var detailID = NSString()
    var detailURL = "http://qingbin.sinaapp.com/api/html"
    var webView : UIWebView?
    
    func loadDataSource() {
        var urlString = detailURL + "\(detailID).html"
        var url = NSURL.init(string: urlString)
        var urlRequest = NSURLRequest(URL: NSURL.init(string: urlString)!)
        webView!.loadRequest(urlRequest)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView()
        webView!.backgroundColor = UIColor.grayColor()
        self.view.addSubview(webView!)
        loadDataSource()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}