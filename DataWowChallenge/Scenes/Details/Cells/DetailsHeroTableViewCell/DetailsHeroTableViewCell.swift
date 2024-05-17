//
//  DetailsHeroTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.

import UIKit
import SVGKit

struct DetailsHeroTableViewCellDisplayModel {
    let imageUrl: URL?
}

class DetailsHeroTableViewCell: UITableViewCell {
    static let identifier = "\(DetailsHeroTableViewCell.self)"
    
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with configurable: DetailsHeroTableViewCellDisplayModel) {
        
        guard let imageUrl = configurable.imageUrl else { return }
        
        ImageURL.getDataFromImageUrl(url: imageUrl) { data, error in
            let svgImage = SVGKImage(data: data)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                heroImageView.image = svgImage?.uiImage
            }
        }
    }
}
