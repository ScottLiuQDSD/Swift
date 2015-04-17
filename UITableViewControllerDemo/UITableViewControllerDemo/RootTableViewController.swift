//
//  ViewController.swift
//  UITableViewControllerDemo
//
//  Created by LiuScott on 15-4-3.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    var dataSource = []
    var thumbQueue = NSOperationQueue()
    let hackerNewApiUrl = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        let refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Drag Down Refresh")
        refreshControl.addTarget(self, action:"loadDataSource", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        loadDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        
        return dataSource.count
    }
    
    func tableView(tableView:UITableView?, numberOfSectionsInTableView section:Int) ->Int {
        return dataSource.count
    }
    
    func loadDataSource() {
        self.refreshControl?.beginRefreshing()
        var loadURL = NSURL.init(string: hackerNewApiUrl)
        var request = NSURLRequest(URL: loadURL!)
        var loadDataSourceQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue:loadDataSourceQueue, completionHandler: {response, data, error in
        if ((error) != nil) {
            println(error)
            dispatch_async(dispatch_get_main_queue(), {
                //self.refreshControl?.endRefreshing()
            })
        } else {
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:nil) as NSDictionary
            let newsDataSource = json["item"] as NSArray
            var currentNewsDataSource = NSMutableArray()
            for currentNews : AnyObject in newsDataSource {
                let newsItem = XHNewsItem()
                newsItem.newsTitle = currentNews["title"] as NSString
                newsItem.newsThumb = currentNews["thumb"] as NSString
                newsItem.newsID = currentNews["id"] as NSString
                currentNewsDataSource.addObject(newsItem)
                println(newsItem.newsTitle)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.dataSource = currentNewsDataSource
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
            }
        })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as UITableViewCell
        let newsItem = dataSource[indexPath.row] as XHNewsItem
        cell.textLabel?.text = newsItem.newsTitle
        cell.imageView?.image = UIImage(named: "cell_photo_default_small")
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        let request = NSURLRequest(URL: NSURL.self.init(string:newsItem.newsThumb)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue, completionHandler: {response, data, error in
            if (error != nil) {
                println(error)
            } else {
                let image = UIImage.init(data : data)
                dispatch_async(dispatch_get_main_queue(), {
                    //cell.imageView?.image = image
                })
            }
        })
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("segue")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var row = indexPath.row as Int
        var data = self.dataSource[row] as XHNewsItem
        
        var webView = WebViewController()
        webView.detailID = data.newsID
        self.navigationController?.pushViewController(webView, animated: true)
        
    }
    
}

