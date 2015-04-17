//
//  TextViewController.swift
//  Psychologist
//
//  Created by LiuScott on 15-4-13.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text :String = "" {
        didSet {
            textView?.text = text
        }
    }
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        println("size new is \(size)")
    }
}
