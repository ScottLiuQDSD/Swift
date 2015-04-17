//
//  SecondViewController.swift
//  ShowView
//
//  Created by LiuScott on 15-3-12.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var myMessage : UILabel?
    var sentMessage : String  = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        myMessage?.text = sentMessage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
