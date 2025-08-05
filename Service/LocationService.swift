//
//  LocationService.swift
//  MapDay
//
//  Created by 이유리 on 7/28/25.
//

import CoreLocation

class LocationService: NSObject {
    static let shared = LocationService()
    @Published var userLocation: (lat: Double, lng: Double) = (0.0, 0.0)
    var locationManager = CLLocationManager()
    let seoul_location = (37.5655278, 126.9777528)
    
    func checkLocationAuthAndGetUserLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("위치 정보 접근이 제한되었습니다.")
        case .denied:
            print("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
        case .authorizedAlways, .authorizedWhenInUse:

            fetchUserLocation()

         default:
            break
        }
    }

    
    func fetchUserLocation() {
        let lat = locationManager.location?.coordinate.latitude
        let lng = locationManager.location?.coordinate.longitude
        
        userLocation = (Double(lat ?? seoul_location.0), Double(lng ?? seoul_location.1))
    }
}
