//
//  UIView+Extension.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 17/5/2567 BE.
//

import UIKit

extension UIView {
    func loadViewFromNib(owner: UIView) {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: owner))
        guard let contentView = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: nil).first as? UIView else {
            fatalError("Failed to load view from nib")
        }
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
}
