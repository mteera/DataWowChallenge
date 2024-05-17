//
//  PokemonTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 14/5/2567 BE.
//

import UIKit
import SVGKit

struct PokemonTableViewCellDisplayModel {
    let name: String
    let imageUrl: URL?
}

final class PokemonTableViewCell: UITableViewCell {
    static let identifier = "\(PokemonTableViewCell.self)"
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(with configurable: PokemonTableViewCellDisplayModel) {
        titleLabel.text = configurable.name
        
        guard let imageUrl = configurable.imageUrl else { return }
        
        ImageURL.getDataFromImageUrl(url: imageUrl) { data, error in
            let svgImage = SVGKImage(data: data)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                avatarImageView.image = svgImage?.uiImage
            }
        }
    }
}
