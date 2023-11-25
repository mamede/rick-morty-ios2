//
//  RickAndMortyViewModel.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import Foundation

class RickAndMortyViewModel: ObservableObject {
    @Published var data = [RMCharacters]()
    
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

