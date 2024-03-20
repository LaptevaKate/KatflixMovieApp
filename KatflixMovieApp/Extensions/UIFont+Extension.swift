//
//  UIFont+Extension.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 20.03.24.
//

import UIKit

enum CustomFonts: String {
    case titleFont = "dancing-in-the-rainbow"
    case textFont1 = "comfortaa-7"
    case textFont2 = "ubuntuItalic"
}

enum CustomFontSize: CGFloat {
    case small = 16.0
    case medium = 19.0
    case large = 24.0
}

extension UIFont {
    static func customFont(font: CustomFonts, size: CustomFontSize) -> UIFont {
        let fontName = font.rawValue
        guard let font = UIFont(name: fontName, size: size.rawValue) else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
        return font
    }
}
