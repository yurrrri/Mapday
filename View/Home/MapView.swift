//
//  MapView.swift
//  MapDay
//
//  Created by 이유리 on 7/18/25.
//

import SwiftUI
import NMapsMap
import Combine

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> NMFNaverMapView
 {
     context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView
, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    class Coordinator: NSObject, ObservableObject,
                       NMFMapViewCameraDelegate,
                       NMFMapViewTouchDelegate {
        
        static let shared = Coordinator()
        @Published var places: [PlaceInfo] = []
        private var markers: [NMFMarker] = []

        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        let view = NMFNaverMapView(frame: .zero)
        
        private var cancellables = Set<AnyCancellable>()
        
        override init() {
            super.init()
            
            initMap()
            
            bindLocationUpdates()
        }
        
        private func initMap() {
            view.mapView.positionMode = .direction
            view.mapView.zoomLevel = 15
            view.mapView.minZoomLevel = 1
            view.mapView.maxZoomLevel = 17
            
            view.showLocationButton = true
            view.showZoomControls = true
            view.showCompass = true
            view.showScaleBar = true
            
            view.mapView.addCameraDelegate(delegate: self)
            view.mapView.touchDelegate = self
            
            dataSource.title = "정보 창 내용"
            infoWindow.dataSource = dataSource
        
        }
        
        private func bindLocationUpdates() {
            LocationService.shared.$userLocation
                .receive(on: RunLoop.main)
                .sink { [weak self] location in
                    guard let self = self else { return }
                    
                    self.updateMapLocation(lat: location.lat, lng: location.lng)
                    
                    self.loadNearbyRestaurants(lat: location.lat, lng: location.lng)
                }
                .store(in: &cancellables)
        }
        
        private func loadNearbyRestaurants(lat: Double, lng: Double) {
            
            RestaurantSerachAPIService.shared.fetchNearbyRestaurants(lat: lat, lng: lng)
                .receive(on: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            print("🍽️ 식당 검색 실패: \(error.localizedDescription)")
                        }
                    },
                    receiveValue: { [weak self] places in
                        self?.addPlaceMarkers(places)
                    }
                )
                .store(in: &cancellables)
        }
        
        private func updateMapLocation(lat: Double, lng: Double) {
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 15)
            cameraUpdate.animationDuration = 1
            
            view.mapView.locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
            view.mapView.locationOverlay.hidden = false
            
            view.mapView.moveCamera(cameraUpdate)
        }

        func getNaverMapView() -> NMFNaverMapView {
            return view
        }
        
        private func addPlaceMarkers(_ places: [PlaceInfo]) {
            // 이전 마커 제거
            markers.forEach { $0.mapView = nil }
            markers.removeAll()
            
            let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
                if let marker = overlay as? NMFMarker {
                    // 정보 창이 열린 마커의 tag를 텍스트로 노출하도록 반환
                    self?.dataSource.title = marker.userInfo["tag"] as! String
                    // 마커를 터치할 때 정보창을 엶
                    self?.infoWindow.open(with: marker)
                }
                return true
            };
            
            for place in places {
                guard let lat = Double(place.y), let lng = Double(place.x) else { continue }
                
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: lat, lng: lng)
                marker.iconImage = NMFOverlayImage(name: "chili-pepper")
                marker.width = 30
                marker.height = 40
                marker.mapView = view.mapView
                marker.userInfo = ["tag": place.placeName]
                marker.touchHandler = handler
                
                markers.append(marker)
            }
        }
    
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            infoWindow.close()
        }
    }
}

#Preview {
    MapView()
}
