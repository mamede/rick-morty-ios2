//
//  RickAndMortyViewModel.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import Foundation

class RickAndMortyViewModel: ObservableObject {
    @Published var data = [RMCharacters]()
       @Published var favorites: [RMCharacters] = [] {
            didSet {
                let ids = favorites.map { $0.id }
                UserDefaults.standard.set(ids, forKey: "favorites")
            }
       }

    init() {
        let ids = UserDefaults.standard.array(forKey: "favorites") as? [Int] ?? []
        let group = DispatchGroup()

        for id in ids {
            group.enter()
            fetchCharacterById(id: id) { character in
                if let character = character {
                    DispatchQueue.main.async {
                        self.favorites.append(character)
                    }
                }
                group.leave()
            }
        }

        group.wait()
    }

    func fetchCharacterById(id: Int, completion: @escaping (RMCharacters?) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let character = try? decoder.decode(RMCharacters.self, from: data) {
                    completion(character)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }

    func addToFavorites(character: RMCharacters) {
      if !favorites.contains(where: { $0.id == character.id }) {
          favorites.append(character)
      }
    }

    func removeFromFavorites(character: RMCharacters) {
      if let index = favorites.firstIndex(where: { $0.id == character.id }) {
        favorites.remove(at: index)
      }
    }
    func getData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let rickAndMorty = try! JSONDecoder().decode(RickAndMortyModel.self, from: data!)
            
            DispatchQueue.main.async {
                self.data = rickAndMorty.results
            }
        }
        .resume()
    }
}

