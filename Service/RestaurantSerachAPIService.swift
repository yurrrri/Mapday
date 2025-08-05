//
//  RestaurantSerachAPIService.swift
//  MapDay
//
//  Created by 이유리 on 7/28/25.
//

import Foundation
import Combine
import Alamofire

class RestaurantSerachAPIService: NSObject {
    private let kakaoAPIKey = Bundle.main.infoDictionary!["KAKAO_API_KEY"] as! String
    static let shared = RestaurantSerachAPIService()
    
    func fetchNearbyRestaurants(lat: Double, lng: Double) -> AnyPublisher<[PlaceInfo], AFError> {

        let url = "https://dapi.kakao.com/v2/local/search/category.json"
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(kakaoAPIKey)"
        ]
        
        let params: Parameters = [
            "category_group_code": "FD6",
            "x": lng,
            "y": lat,
            "radius": "500",
            "sort": "distance"
        ]
        
        return AF.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: headers)
            .publishDecodable(type: ResturantInfo.self)
            .value()
            .map(\.places)
            .eraseToAnyPublisher()
    }
}
