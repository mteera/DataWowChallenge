//
//  DetailsHeroTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import UIKit

struct DetailsInformationTableViewCellDisplayModel {
    let name: String
    let number: String
    let types: [String]
    let description: String
}

class DetailsInformationTableViewCell: UITableViewCell {
    static let identifier = "\(DetailsInformationTableViewCell.self)"

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var typeStackView: UIStackView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        typeStackView.removeAllArrangedSubviews()
        nameLabel.text = ""
        numberLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func configure(with configurable: DetailsInformationTableViewCellDisplayModel) {
        backgroundColor = .white
        nameLabel.text = configurable.name
        numberLabel.text = configurable.number
        descriptionLabel.text = configurable.description
        
        typeStackView.removeAllArrangedSubviews()
        configurable.types.forEach { type in
            let typeView: TypeView = TypeView()
            typeView.configure(with: TypeViewDisplayModel(value: type))
            typeStackView.addArrangedSubview(typeView)
        }
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}