//
//  TypeView.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import UIKit

struct TypeViewDisplayModel {
    let value: String
}

class TypeView: UIView {
    
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(owner: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(owner: self)
        

    }
    
    func configure(with configurable: TypeViewDisplayModel) {
        valueLabel.text = configurable.value
    }
}
