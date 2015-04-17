//
//  HappinessViewController.swift
//  Happniess
//
//  Created by LiuScott on 15-4-7.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scaleMe:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    
    var happiness : Int = 50 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended : fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
                if happinessChange != 0 {
                    happiness += happinessChange
                    gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    private func updateUI() {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    override func viewDidLoad() {
        
    }
}
