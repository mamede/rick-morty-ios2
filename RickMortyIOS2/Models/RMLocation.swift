//
//  RMLocation.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
