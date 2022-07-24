//
//  ViewController.swift
//  calc
//
//  Created by Алексей Грачев on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTaping = false
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign:String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            stillTaping = false
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
//        print(number)
        if stillTaping {
            if (displayResultLabel.text?.count)! < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTaping = true
        }
        
    }
    @IBAction func twoOperandSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        print(firstOperand)
        print(operationSign)
        stillTaping = false
        dotIsPlased = false
    }
    func operateWithTwoOperands(operation: (Double , Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTaping = false
    }
    @IBAction func equalSignPressed(_ sender: UIButton) {
        if stillTaping  {
            secondOperand = currentInput
        }
        dotIsPlased = false
        switch operationSign {
        case "+":
             operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:break
        }
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTaping = false
        dotIsPlased = false
        operationSign = ""
    }
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
            stillTaping = false
        }
    }
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTaping && !dotIsPlased {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlased = true
        } else if !stillTaping && !dotIsPlased {
            displayResultLabel.text = "0."
        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

