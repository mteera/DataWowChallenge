//
//  PokemonTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 14/5/2567 BE.
//

import UIKit
import Kingfisher
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
        avatarImageView.kf.cancelDownloadTask()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(with configurable: PokemonTableViewCellDisplayModel) {
        titleLabel.text = configurable.name
        
        guard let imageUrl = configurable.imageUrl else { return }
        
        let loader = avatarImageView.superview?.showLoader()

        avatarImageView.kf.setImage(
            with: imageUrl,
            options: [.processor(SVGImgProcessor())],
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    loader.map { self.avatarImageView.superview?.hideLoader(loader: $0) }
                }
            }
        )
    }
}
