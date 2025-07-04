//
//  SplashView.swift
//  MapDay
//
//  Created by 이유리 on 7/4/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            VStack (spacing: 20) {
                
                Text("스플래시뷰")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor.opacity(0.8))
                    .fontWeight(.heavy)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
