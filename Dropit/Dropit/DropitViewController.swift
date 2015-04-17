//
//  DropitViewController.swift
//  Dropit
//
//  Created by LiuScott on 15-4-16.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: BezierPathView!

    let dropBehavior = DropitBehavior()
    
    var attachment : UIAttachmentBehavior? {
        willSet {
            animator.removeBehavior(attachment)
            gameView.setPath(nil, named: PathNames.Attachment)
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment)
                attachment?.action = { [unowned self] in
                    if let attachedView = self.attachment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachedView.center)
                        self.gameView.setPath(path, named: PathNames.Attachment)
                        
                    }

                }
            }
        }
    }
    
    lazy var animator : UIDynamicAnimator = {
        let lazilyCreateDynamicAnimatior = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreateDynamicAnimatior.delegate = self
        return lazilyCreateDynamicAnimatior
    }()
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
//    func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropBehavior)
    }
    struct PathNames {
        static let Middlebarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrgin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrgin, size: barrierSize))
        dropBehavior.addBarrier(path, named: PathNames.Middlebarrier)
        gameView.setPath(path, named: PathNames.Middlebarrier)
    }
    
    
    var dropsPerRow = 10
    
    var dropSize : CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }

    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.locationInView(gameView)
        switch sender.state {
        case .Began:
            if let viewToAttachTo = lastDroppedView {
                attachment = UIAttachmentBehavior(item: lastDroppedView!, attachedToAnchor: gesturePoint)
                lastDroppedView = nil
            }
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default: break
        }
    }
    var lastDroppedView : UIView?
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        gameView.addSubview(dropView)
        
        lastDroppedView = dropView
        
        dropBehavior.addDrop(dropView)
    }
    
    func removeCompletedRow() {
        var dropsToRemove = [UIView]()
        
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        
        do {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
        
            var dropsFound = [UIView]()
            var rowIsCompleted = true
            for _ in 0 ..< dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil) {
                    dropsFound.append(hitView)
                } else {
                    rowIsCompleted = false
                }
                dropFrame.origin.x += dropSize.width
            }
            if rowIsCompleted {
                dropsToRemove += dropsFound
            }
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropBehavior.removeDrop(drop)
        }
    }
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random : UIColor {
        switch arc4random() % 5 {
            case 0 : return UIColor.greenColor()
            case 1 : return UIColor.blueColor()
            case 2 : return UIColor.orangeColor()
            case 3 : return UIColor.redColor()
            case 4 : return UIColor.blackColor()
        default : break
        }
        return UIColor.whiteColor()
    }
}