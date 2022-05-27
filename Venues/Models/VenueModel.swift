//
//  VenueModel.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 26/05/2022.
//

import Foundation

struct VenueModel: Codable {
    let categories: [CategoriesModel]
    let name : String
}
