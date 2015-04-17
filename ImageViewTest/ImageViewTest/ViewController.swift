//
//  ViewController.swift
//  ImageViewTest
//
//  Created by LiuScott on 15-3-31.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var backgroundView: UIImageView?
    @IBOutlet var myLabel: UILabel?
    
    var imageList: [String] = ["Palms.jpg", "Mountain.jpg", "NewYork.jpg"]
    var nameList: [String] = ["Beach Vaction", "Hike", "Big City"]
    let maxImages = 2
    var imageIndex = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundView?.image = UIImage(named: "Palms.jpg")
        myLabel?.text = nameList[0];
    }

    @IBAction func nextIamge() {
        if imageIndex > maxImages {
            imageIndex = 0;
        }
        backgroundView?.image = UIImage(named: imageList[imageIndex]);
        myLabel?.text = nameList[imageIndex];
        imageIndex++
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

