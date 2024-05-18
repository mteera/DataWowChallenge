//
//  UIViewController+Extension.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 18/5/2567 BE.
//

import UIKit

extension UIViewController {
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
