//
//  ViewController.swift
//  Calculator
//
//  Created by formation 1 on 28/11/2018.
//  Copyright © 2018 formation 1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let COMA_DIGIT : String = "."
    var lastValue : Float = 0.0
    var lastOperand : String = ""
    var operandFuncs : [String: (Float, Float) -> Float]
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        func addition (_ f : Float, _ s : Float) -> Float {return f + s}
        func substract (_ f : Float, _ s : Float) -> Float {return f - s}
        func times (_ f : Float, _ s : Float) -> Float {return f * s}
        func divide (_ f : Float, _ s : Float) -> Float {return f / s}
        
        operandFuncs = ["+": addition, "-": substract, "*": times, "/": divide]
        
        super.init(coder: aDecoder)
    }
    
    // Helper functions
    
    func isThereOnlyZerosOnResultLabel() -> Bool {
        let actualValue : String = resultLabel.text ?? ""
        if actualValue == "0." {
            return false;
        }
        if Float(actualValue) == 0.0 {
            return true
        }
        return false
    }
    
    func showResult() {
        resultLabel.text = String(lastValue)
    }
    
    func resetResultLabel() {
        resultLabel.text = "0"
    }
    
    // UI events functions
    
    @IBAction func onOperatorPressed(_ sender: UIButton) {

        // case lastOperand is +, -, *, /
        
        if lastOperand != "" && lastOperand != "=" {
            if let operationToresolve = operandFuncs[lastOperand] {
                let currentValue : Float = Float(resultLabel.text ?? "0") ?? 0.0
                lastValue = operationToresolve(lastValue, currentValue)
            }
        }
        
        // case this is the first operator pressed
        else {
            lastValue = Float(resultLabel.text ?? "0") ?? 0.0
        }

        resetResultLabel()
        
        let currentOperator : String = sender.titleLabel?.text ?? ""

        if currentOperator == "=" {
            showResult()
        }
        lastOperand = currentOperator
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let onlyZeros : Bool = isThereOnlyZerosOnResultLabel()
        let textButtonLabel : String = sender.titleLabel?.text ?? ""
        
        if (lastOperand == "=") {
            resetResultLabel()
            lastValue = 0.0
        }
        if (onlyZeros && textButtonLabel == COMA_DIGIT) {
            resultLabel.text = "0."
        }
        else if onlyZeros {
            resultLabel.text = textButtonLabel
        }
        else {
            resultLabel.text?.append(textButtonLabel)
        }
    }
}
