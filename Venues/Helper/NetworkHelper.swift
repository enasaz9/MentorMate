//
//  NetworkHelper.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 26/05/2022.
//

import Foundation

// Enum for API URLs used
enum API_URLs: String {
    case PlacesSearch = "https://api.foursquare.com/v3/places/search"
}

// Enum for expected Network errors used
enum NetworkError: Error {
    case noData
    case networkError
}

// App's constant
let fourSquareAPIKey = "fsq39CnHs0rhxeTyC5QHlajkhPnMczGk+u9JCWPCfHCyMa0="
let placesSearchLimit = "5"
let placesSearchCriteria = "DISTANCE"

