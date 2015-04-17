//
//  ViewController.swift
//  ShowView
//
//  Created by LiuScott on 15-3-12.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showView() {
        let vc = SecondViewController(nibName:"SecondViewController", bundle: nil);
        vc.sentMessage = "Hello Scott.";
        showViewController(vc, sender: self)
    }
    

}

