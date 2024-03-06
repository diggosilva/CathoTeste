//
//  Extensions.swift
//  CathoTeste
//
//  Created by Diggo Silva on 29/02/24.
//

import UIKit

extension UIColor {
    static let azulCatho = #colorLiteral(red: 0.2132410109, green: 0.4071893096, blue: 0.7987419963, alpha: 1)
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }
}

extension UIDevice {
    static let isiPhone = UIDevice.current.userInterfaceIdiom == .phone
}
