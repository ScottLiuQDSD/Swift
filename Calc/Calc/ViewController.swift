//
//  ViewController.swift
//  Calc
//
//  Created by LiuScott on 15-4-2.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit  = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumber == false {
            if (.OrderedSame == digit.compare(".")) {
                display.text? = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTypingANumber = true
        } else {
            if (.OrderedSame == digit.compare(".") && (display.text?.rangeOfString(".")) != nil) {
                println("there is already have a dot.")
            } else {
                display.text? += digit
            }
        }
    }
    @IBAction func clearStack(sender: UIButton) {
        display.text? = " "
        history.text? = ""
        brain.clearStack()
    }

    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false;
        if let result = brain.pushOperand(displayValue!) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    var displayValue: Double? {
        get {
            if .OrderedSame == display.text!.compare("π") {
                return M_PI
            }
            if (display.text!.isEmpty == false) {
                return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
            } else {
                return 0
            }
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func operationCalc(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                history.text = brain.getHistory()! + "="
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

}

