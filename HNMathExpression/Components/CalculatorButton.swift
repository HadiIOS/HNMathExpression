//
//  CalculatorButton.swift
//  HNMathExpression
//
//  Created by Hady Nourallah on 21/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@IBDesignable class CalculatorButton: UIButton {

    @IBInspectable var normalColor: UIColor? {
        didSet {
            self.backgroundColor = normalColor
        }
    }
    
    @IBInspectable var highlightColor: UIColor?
    
    private var animator = UIViewPropertyAnimator()

    private func setup() {
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    @objc private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
        })
        animator.startAnimation()
    }

    @objc private func touchDown() {
        animator.stopAnimation(true)
        backgroundColor = self.highlightColor
    }
    
}
