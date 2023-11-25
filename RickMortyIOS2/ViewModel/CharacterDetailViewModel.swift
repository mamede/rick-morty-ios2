//
//  CharacterDetailViewModel.swift
//  Rick morty IOS 2
//
//  Created by Felipe Mamede on 25/11/23.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: RMCharacters?

    func getCharacterDetails(id: Int) {
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(RMCharacters.self, from: data) {
                    DispatchQueue.main.async {
                        self.character = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        task.resume()
    }
}
