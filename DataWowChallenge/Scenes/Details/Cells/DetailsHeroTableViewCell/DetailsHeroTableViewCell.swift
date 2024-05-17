//
//  DetailsHeroTableViewCell.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import UIKit

struct DetailsHeroTableViewCellDisplayModel {
    let imageUrl: URL
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

    }

}
