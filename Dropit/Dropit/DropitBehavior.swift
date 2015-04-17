//
//  DropitBehavior.swift
//  Dropit
//
//  Created by LiuScott on 15-4-16.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {
    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior = {
        let lazilyCollider = UICollisionBehavior()
        lazilyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCollider
    }()
    
    lazy var dropBehavior : UIDynamicItemBehavior = {
        let lazilyCreatedDropBehavior = UIDynamicItemBehavior()
        lazilyCreatedDropBehavior.allowsRotation = false
        lazilyCreatedDropBehavior.elasticity = 0.75
        return lazilyCreatedDropBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    
    
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    func addDrop(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
