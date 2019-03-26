//
//  ViewController.swift
//  HNMathExpression
//
//  Created by Mac on 20/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HNCalKeypadDelegate {
    
    @IBOutlet weak var keypad: HNCalKeypad!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addLiveBackground()
        keypad.loadKeypad()
        keypad.delegate = self
        self.label.isUserInteractionEnabled = true
        self.label.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeLabel(_:))))
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func didSwipeLabel(_ swipeGesture: UISwipeGestureRecognizer) {
        self.label.text = String(self.label.text?.dropLast() ?? "")
    }

    func didSelectkey(_ key: HNCalKeypad.Keypad) {
        switch key {
        case .clear:
            self.label.text = nil
        case .openP:
            
            if let last = self.label.text?.last, String(last).isNumeric, self.label.text?.isEmpty == false {
               labelAppendText(HNCalKeypad.Keypad.mult.rawValue)
            }
            labelAppendText(key.rawValue)
        case .neg:
            if self.textContainsOperation(self.label.text ?? "") {
                //this regex format to achieve "-(*)"
                if self.label.text?.matches("^−\\(.*\\)$") == true {
                    self.label.text = String(self.label.text?.dropFirst(2).dropLast() ?? "")
                } else {
                    self.label.text = "−(\(self.label.text ?? ""))"
                }
            } else if let i = Int(self.label.text ?? "") {
                self.label.text = "\(-1 * i)"
            }
            
        case .equal:
            if self.label.text?.contains("=") == true{
                return 
            }
            let (answer, error) = HNMathExpression(self.label.text?.fixedString ?? "").evaluate()
            if let error = error {
                self.label.text = error.message
            } else if let a = answer {
                self.label.text = "= \(a)"
            } else {
                self.label.text = "Error"
            }
        case .dot:
            if !(self.label.text?.isNumeric == true) {
                labelAppendText("0")
            }
            labelAppendText(key.rawValue)

        default:
            labelAppendText(key.rawValue)
        }
    }
    
    func textContainsOperation(_ string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "×÷−+()")) != nil &&
            string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
    
    func labelAppendText(_ c: String) {
        if self.label.text?.contains("=") == true || self.label.text?.contains("Error") == true  {
         self.label.text = ""
        }
        
        var text = self.label.text ?? ""
        text.append(c)
        self.label.text = text
    }
}

extension String {
    var fixedString: String {
        return self.replacingOccurrences(of: "×", with: "*").replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "−", with: "-")
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
