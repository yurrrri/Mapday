//
//  Font+Figma.swift
//  MapDay
//
//  Created by 이유리 on 7/11/25.
//

import SwiftUI

extension Font {
    enum PretendardWeight {
        case bold
        case extrabold
        case extralight
        case light
        case medium
        case regular
        case semibold
        case thin
        
        var value: String {
            switch self {
            case .bold:
                return "Bold"
            case .extrabold:
                return "ExtraBold"
            case .extralight:
                return "ExtraLight"
            case .light:
                return "Light"
            case .medium:
                return "Medium"
            case .regular:
                return "Regular"
            case .semibold:
                return "SemiBold"
            case .thin:
                return "Thin"
            }
        }
    }
    
    static func pretendard(size fontSize: CGFloat, weight: PretendardWeight) -> Font {
        let familyName = "Pretendard"
        let weightString = weight.value

        return Font.custom("\(familyName)-\(weightString)", size: fontSize)
    }
}
