//
//  ViewController.swift
//  GACalculatorMidTerm
//
//  Created by William Chang on 2/1/16.
//  Copyright © 2016 WillChang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayTextField: UITextField!
    
    var firstNumberString = ""
    var currNumberString = ""
    var lastOperatorString = ""
    var returnNumber = 0.0
    var isDecimalFirst = false
    var isDecimalCurr = false
    var isReturned = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTextField.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        
        //so it doesn't show a zero before a number is added
        if displayTextField.text == "0"{
            displayTextField.text = ""
        }
        
        let numberString = sender.titleLabel?.text!
        let displayString=displayTextField.text!
        displayTextField.text = displayString + numberString!
        if lastOperatorString == ""{
            firstNumberString = displayTextField.text!
        }else{
            currNumberString = displayTextField.text!
        }
    }
    
    @IBAction func decimalPressed(sender: UIButton) {
        
        let numberString = "."
        let displayString=displayTextField.text!
        if !isDecimalFirst && currNumberString == ""{
            displayTextField.text = displayString + numberString
            isDecimalFirst = true
        } else if !isDecimalCurr {
            displayTextField.text = displayString + numberString
            isDecimalCurr = true
        }
    }
    
    @IBAction func percentPressed(sender: UIButton) {
        if returnNumber != 0.0 {
            returnNumber=returnNumber/100
        } else if currNumberString != ""{
            let currNumber:Double! = Double(currNumberString)
            returnNumber=currNumber/100
        }else if firstNumberString != ""{
            let currNumber:Double! = Double(firstNumberString)
            returnNumber=currNumber/100
        }
        isReturned=true
        displayTextField.text = "\(returnNumber)"
        
        
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        if let operatorString = sender.titleLabel?.text!{
            lastOperatorString = operatorString
            //displayTextField.text = operatorString
            displayTextField.text = ""
            //allows continuation of operands on return value
            if isReturned{
                isReturned = false
                isDecimalCurr = false
                firstNumberString="\(returnNumber)"
            }
        }
    }
    
    @IBAction func returnResult(sender: AnyObject) {
        if firstNumberString != "" && currNumberString != ""  && lastOperatorString != "" {
            let firstNumber:Double! = Double(firstNumberString)
            let secondNumber:Double! = Double(currNumberString)
            returnNumber = 0.0
            if lastOperatorString == "➗"{
                returnNumber = firstNumber/secondNumber
            } else if lastOperatorString == "✖️"{
                returnNumber = firstNumber*secondNumber
            } else if lastOperatorString == "➖"{
                returnNumber = firstNumber-secondNumber
            } else if lastOperatorString == "➕"{
                returnNumber = firstNumber+secondNumber
            }
            
            displayTextField.text = "\(returnNumber)"
            isReturned = true
        }
        
        
    }
    
    
    @IBAction func inversePressed(sender: UIButton) {
        
        if firstNumberString != "" && currNumberString == ""{
            let currNumber=inverseNumber(firstNumberString)
            returnNumber=currNumber
        } else if currNumberString != "" && !isReturned{
            let currNumber=inverseNumber(currNumberString)
            returnNumber=currNumber
        } else {
            returnNumber=inverseNumber("\(returnNumber)")
        }
        
        isReturned=true
        displayTextField.text = "\(returnNumber)"
        
    }

    
    func inverseNumber(string:String) ->Double{
        let currNumber:Double! = Double(string)
        if currNumber < 0{
            return (-1 * currNumber)
        }else if currNumber > 0{
            return 0 - currNumber
        }
        
        return 0
    }
    
    @IBAction func reset(sender: AnyObject) {
        firstNumberString = ""
        currNumberString = ""
        lastOperatorString = ""
        returnNumber = 0.0
        isDecimalFirst = false
        isDecimalCurr = false
        isReturned = false
        displayTextField.text = "0"
    }
    
    
}

