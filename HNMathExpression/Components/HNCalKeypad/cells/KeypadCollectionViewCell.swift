//
//  KeypadCollectionViewCell.swift
//  HNMathExpression
//
//  Created by Hady Nourallah on 22/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class KeypadCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var visualEffectView: UIVisualEffectView!
    @IBOutlet weak private var button: CalculatorButton!
    
    weak var delegate: KeypadCollectionCellDelegate?
    
    func setupCell(_ keypad: HNCalKeypad.Keypad) {
        
        button.setTitle(keypad.rawValue, for: .normal)
        self.layoutIfNeeded()
    }
    
    func setupUI() {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 5
        
        visualEffectView.layer.cornerRadius = visualEffectView.frame.height / 2
        visualEffectView.layer.masksToBounds = true
        visualEffectView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnDidClick(_ sender: Any) {
        self.delegate?.didSelectButton(at: self)
    }
}

protocol KeypadCollectionCellDelegate: class {
    func didSelectButton(at cell: KeypadCollectionViewCell)
}
