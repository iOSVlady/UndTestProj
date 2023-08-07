//
//  FontExtension.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 14.07.2023.
//

import SwiftUI
import UIKit

extension Font {
    enum FontFamily: String {
        case nunito = "Nunito"
        case jost = "Jost"
    }

    enum FontStyle: String {
        case black
        case blackItalic = "blackitalic"
        case bold
        case boldItalic = "bolditalic"
        case extraBold = "extrabold"
        case extraBoldItalic = "extrabolditalic"
        case extraLight = "extralight"
        case extraLightItalic = "extralightitalic"
        case italic
        case light
        case lightItalic = "lightitalic"
        case medium
        case mediumItalic = "mediumitalic"
        case regular
        case semiBold = "semibold"
        case semiBoldItalic = "semibolditalic"
    }

    static func customFont(family: FontFamily, style: FontStyle, size: CGFloat) -> Font {
        let fontName = "\(family.rawValue)-\(style.rawValue.capitalized)"
        if let font = UIFont(name: fontName, size: size) {
            return Font(font)
        } else {
            return Font.system(size: size)
        }
    }
}

extension UIFont {
    enum FontFamily: String {
        case nunito = "Nunito"
        case jost = "Jost"
    }

    enum FontStyle: String {
        case black
        case blackItalic = "blackitalic"
        case bold
        case boldItalic = "bolditalic"
        case extraBold = "extrabold"
        case extraBoldItalic = "extrabolditalic"
        case extraLight = "extralight"
        case extraLightItalic = "extralightitalic"
        case italic
        case light
        case lightItalic = "lightitalic"
        case medium
        case mediumItalic = "mediumitalic"
        case regular
        case semiBold = "semibold"
        case semiBoldItalic = "semibolditalic"
    }

    static func customFont(family: FontFamily, style: FontStyle, size: CGFloat) -> UIFont {
        let fontName = "\(family.rawValue)-\(style.rawValue.capitalized)"
        if let font = UIFont(name: fontName, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
