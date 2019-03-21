//
//  ViewController.swift
//  HNMathExpression
//
//  Created by Mac on 20/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(HNMathExpression("1").evaluate().0 ?? -1.0) //1
//        print(HNMathExpression("1+1").evaluate().0 ?? -1.0) //1
//        print(HNMathExpression("(1-2)/3.0 + 0.0000").evaluate().0 ?? -1.0) //-0.33333333333
//        print(HNMathExpression("1.0 / 3 * 6").evaluate().0 ?? -1.0) //2
//        print(HNMathExpression("(25 + 24) * (245 + 4)").evaluate().0 ?? -1.0) //12201
//        print(HNMathExpression("1+1*5-1+4-1").evaluate().0 ?? -1.0) //8
        print(HNMathExpression("34*54 + (45) +54+1-54/245").evaluate().0 ?? -1.0) //82674.7795918


        // Do any additional setup after loading the view, typically from a nib.
    }


}

