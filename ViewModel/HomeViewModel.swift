//
//  HomeViewModel.swift
//  MapDay
//
//  Created by 이유리 on 7/4/25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {

    @Published var places: [PlaceInfo] = []

    private var cancellables = Set<AnyCancellable>()
}
