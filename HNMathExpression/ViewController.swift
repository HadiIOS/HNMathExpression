//
//  ViewController.swift
//  HNMathExpression
//
//  Created by Mac on 20/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var keypad: HNCalKeypad!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addLiveBackground()
        keypad.loadKeypad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

