//
//  JieDetailViewController.swift
//  Smashtag
//
//  Created by LiuScott on 15-4-15.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit
import MediaPlayer

class JieDetailViewController: UIViewController {

    @IBOutlet weak var big_video_img: UIImageView!
    
    var detailItem : NSDictionary?
    var player : MPMoviePlayerViewController!
    
    func configureView() {
        if let detail : NSDictionary = self.detailItem {
            self.title = detail.objectForKey("video_title") as? String
            let url :String = detail.objectForKey("video_img") as String
            let dataImg : NSData = NSData(contentsOfURL: NSURL(string: url)!)!
            self.image = UIImage(data: dataImg)
            let video_url = NSURL(string: detail.objectForKey("video_url") as String)
            player = MPMoviePlayerViewController(contentURL: video_url)
            presentViewController(player, animated: true, completion: nil)
        }
    }
    
    var image : UIImage? {
        get {
            return big_video_img.image
        }
        set {
            big_video_img.image = newValue
            if let constrainedView = big_video_img {
                if let newImage = newValue {
                    aspectRationConstraint = NSLayoutConstraint(item: constrainedView, attribute: .Width, relatedBy: .Equal, toItem: constrainedView, attribute: .Height, multiplier: newImage.aspectRatio, constant: 0)
                } else {
                    aspectRationConstraint = nil
                }
            }
        }
    }
    var aspectRationConstraint : NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRationConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstrain = aspectRationConstraint {
                view.addConstraint(newConstrain)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension UIImage
{
    var aspectRatio : CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}