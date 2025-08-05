//
//  UIApplication.swift
//  MapDay
//
//  Created by 이유리 on 7/24/25.
//

import UIKit

extension UIApplication {
    var statusBarHeight: CGFloat {
        let window = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first

        return window?.safeAreaInsets.top ?? 0
    }
}
