//
//  RestaurantInfo.swift
//  MapDay
//
//  Created by 이유리 on 7/28/25.
//

import Foundation

// MARK: - ResturantInfo
struct ResturantInfo: Codable {
    let places: [PlaceInfo]
    
    enum CodingKeys: String, CodingKey {
        case places = "documents"
    }
}

// MARK: - PlaceInfo
struct PlaceInfo: Codable {
    let placeName: String
    let placeURL: String
    let categoryName, addressName, roadAddressName, id: String
    let phone, x, y: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case placeURL = "place_url"
        case categoryName = "category_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case id, phone
        case x, y
    }
}

