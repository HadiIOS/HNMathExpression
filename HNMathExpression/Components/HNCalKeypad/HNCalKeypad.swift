//
//  HNCalKeypad.swift
//  HNMathExpression
//
//  Created by Hady Nourallah on 22/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

protocol HNCalKeypadDelegate: class {
    func didSelectkey(_ key: HNCalKeypad.Keypad)
}

class HNCalKeypad: UIView, UICollectionViewDelegate, UICollectionViewDataSource, KeypadCollectionCellDelegate {
    private let keypads: [Keypad] =
        [.clear, .openP, .closeP,.div,
         .seven, .eight, .nine,  .mult,
         .four,  .five,  .six,   .minus,
         .one,   .two,   .three, .plus,
         .zero,  .dot,   .neg,   .equal]
    
    @IBOutlet weak private var collectionViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet private var contentView: UIView!
    
    weak var delegate: HNCalKeypadDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HNCalKeypad", owner: self, options: nil)
        addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func loadKeypad() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(KeypadCollectionViewCell.XIB_FILE, forCellWithReuseIdentifier: KeypadCollectionViewCell.IDENTIFIER)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.frame.width / 4, height: self.frame.height / 5)
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.performBatchUpdates(nil) { (completed) in
            if completed {
                let height = self.collectionView.frame.height - self.collectionView.contentSize.height
                if height > 0 {
                    self.collectionViewTopLayout.constant = -(height)
                }
            }
        }
    }
    
    //MARK: KeypadCollectionCellDelegate
    func didSelectButton(at cell: KeypadCollectionViewCell) {
        if let row = self.collectionView.indexPath(for: cell)?.row {
            let keypad = keypads[row]
            self.delegate?.didSelectkey(keypad)
            
        }
    }
    
    //MARK: Collection View Delegates & Datasources
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.keypads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: KeypadCollectionViewCell.IDENTIFIER, for: indexPath) as! KeypadCollectionViewCell
        cell.delegate = self
        cell.setupCell(keypads[indexPath.row])
        return cell
    }
    
    //MARK: Keypad Enum
    enum Keypad: String {
        case one    = "1"
        case two    = "2"
        case three  = "3"
        case four   = "4"
        case five   = "5"
        case six    = "6"
        case seven  = "7"
        case eight  = "8"
        case nine   = "9"
        case zero   = "0"
        case plus   = "+"
        case minus  = "−"
        case mult   = "×"
        case div    = "÷"
        case equal  = "="
        case neg    = "+/−"
        case dot    = "."
        case openP  = "("
        case closeP = ")"
        case clear  = "C"
    }
}


