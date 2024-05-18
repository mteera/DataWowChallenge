//
//  DetailsHeroTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.

import UIKit
import Kingfisher
import SVGKit

struct DetailsHeroTableViewCellDisplayModel {
    let imageUrl: URL?
}

class DetailsHeroTableViewCell: UITableViewCell {
    static let identifier = "\(DetailsHeroTableViewCell.self)"
    
    @IBOutlet private weak var heroImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with configurable: DetailsHeroTableViewCellDisplayModel) {
        
        guard let imageUrl = configurable.imageUrl else { return }
        
        let loader = heroImageView.superview?.showLoader()

        heroImageView.kf.setImage(
            with: imageUrl,
            options: [.processor(SVGImgProcessor())],
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    loader.map { self.heroImageView.superview?.hideLoader(loader: $0) }
                }
            }
        )
    }
}
