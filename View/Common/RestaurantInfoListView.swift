//
//  RestaurantInfoListView.swift
//  MapDay
//
//  Created by 이유리 on 8/5/25.
//

import SwiftUI

struct RestaurantInfoListView: View {
    
    let place: PlaceInfo
    
    var body: some View {
        HStack {
            VStack(spacing: 8) {
                Text(place.placeName)
                    .font(.pretendard(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("#맛집태그")
                    .font(.pretendard(size: 14, weight: .regular))
                    .foregroundStyle(Color(hex: "#A8A8A8"))
                    .frame(maxWidth: .infinity,
                           alignment: .leading)

            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button {
                    
                } label: {
                    Image("bookmark_blank")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                }
                
                if let url = URL(string: place.placeURL) {
                    Link(destination: url) {
                        Image("link")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(.all, 16)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 14, x: 0, y: 3)
        )
    }
}

#Preview {
    RestaurantInfoListView(place: PlaceInfo(placeName: "마라탕집", placeURL: "http://place.map.kakao.com/16618597", categoryName: "", addressName: "", roadAddressName: "", id: "", phone: "", x: "", y: ""))
}
