//
//  BezierPathView.swift
//  Dropit
//
//  Created by LiuScott on 15-4-16.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class BezierPathView: UIView {

    var bezierPaths = [String : UIBezierPath]()
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }


}
