//
//  HomeView.swift
//  MapDay
//
//  Created by 이유리 on 7/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    MapView()
                        .frame(height: UIScreen.main.bounds.height * 0.4)
                        .onAppear {
                            LocationService.shared.checkLocationAuthAndGetUserLocation()
                        }
                    
                    Button {
                        LocationService.shared.checkLocationAuthAndGetUserLocation()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 38, height: 38)
                            .foregroundColor(.accent)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)

                }
                
                ZStack {
                    Group {
                        Image(systemName: "exclamationmark.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.gray)
                            .frame(width: 50, height: 50)
                        
                        Text("근처 음식점이 없어요.")
                            .font(.pretendard(size: 18, weight: .regular))
                            .foregroundStyle(Color(hex: "#6F6F6F"))
                            .padding(.top, 10)
                    }
                    .opacity(vm.places.isEmpty ? 1 : 0)
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(vm.places, id: \.id) { place in
                                RestaurantInfoListView(place: place)
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .customNavigationBar(title: "")
        }
    }
}

#Preview {
    HomeView(vm: HomeViewModel())
}
