//
//  RickAndMortyModel.swift
//  Rick morty IOS 2
//
//  Created by Felipe Mamede on 25/11/23.
//

import Foundation

struct RickAndMortyModel: Codable {
    struct Info: Codable {
      let count: Int
      let pages: Int
      let next: String?
      let prev: String?
    }

    let info: Info
    let results: [RMCharacters]
}
