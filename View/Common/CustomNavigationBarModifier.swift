//
//  CustomNavigationBarModifier.swift
//  MapDay
//
//  Created by 이유리 on 7/19/25.
//

import SwiftUI

struct CustomNavigationBarModifier<Left: View, Right: View>: ViewModifier {
    let title: String
    let leftView: () -> Left
    let rightView: () -> Right

    init(
        title: String,
        leftView: @escaping () -> Left,
        rightView: @escaping () -> Right
    ) {
        self.title = title
        self.leftView = leftView
        self.rightView = rightView
    }

    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    leftView()
                        .frame(width: 24, height:24)
                    
                    Spacer()
                    
                    rightView()
                        .frame(width: 24, height:24)
                }
                
                Text(title)
                    .font(.pretendard(size: 18, weight: .semibold))
            }
            .padding(.top, UIApplication.shared.statusBarHeight)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .frame(height: 44 + UIApplication.shared.statusBarHeight)

            content
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
    }
}

extension View {
    func customNavigationBar<Left: View, Right: View>(
        title: String,
        leftView: @escaping () -> Left = { EmptyView() },
        rightView: @escaping () -> Right = { EmptyView() }
    ) -> some View {
        modifier(CustomNavigationBarModifier(title: title, leftView: leftView, rightView: rightView))
    }
}
