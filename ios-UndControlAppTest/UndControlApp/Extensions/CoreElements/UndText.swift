//
//  UndText.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 14.07.2023.
//

import Foundation
import SwiftUI

struct UndText: View {
    let family: Font.FontFamily
    let style: Font.FontStyle
    let size: CGFloat
    let text: String

    init(family: Font.FontFamily = .nunito, style: Font.FontStyle = .regular, size: CGFloat = 16, _ text: String) {
        self.family = family
        self.style = style
        self.size = size
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(Font.customFont(family: family, style: style, size: size))
    }
}

