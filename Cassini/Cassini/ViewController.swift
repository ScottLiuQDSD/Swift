//
//  ViewController.swift
//  Cassini
//
//  Created by LiuScott on 15-4-14.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "earth":
                    ivc.imageURL = DemoURL.NASA.Earth
                    ivc.title = "Earth"
                case "saturn":
                    ivc.imageURL = DemoURL.NASA.Saturn
                    ivc.title = "Saturn"
                case "cassini":
                    ivc.imageURL = DemoURL.NASA.Cassini
                    ivc.title = "Cassini"
                default:
                    ivc.imageURL = DemoURL.Stanford
                    ivc.title = "Stanford"
                }
            }
        }
    }


}

