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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with configurable: TypeViewDisplayModel) {
        valueLabel.text = configurable.value
    }
}
