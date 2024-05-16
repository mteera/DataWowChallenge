//
//  PokemonTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 14/5/2567 BE.
//

import UIKit
import Kingfisher

struct PokemonTableViewCellDisplayModel {
    let name: String
    let imageUrl: URL?
}

final class PokemonTableViewCell: UITableViewCell {
    static let identifier = "\(PokemonTableViewCell.self)"
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(with configurable: PokemonTableViewCellDisplayModel) {
        titleLabel.text = configurable.name
        avatarImageView.kf.setImage(with: configurable.imageUrl)
    }
}
