//
//  DetailView.swift
//  Rick morty IOS 2
//
//  Created by Felipe Mamede on 25/11/23.
//

import SwiftUI

struct DetailView: View {
    let characterId: Int
    @StateObject var viewModel = CharacterDetailViewModel()

    var body: some View {
        VStack {
            if let character = viewModel.character {
                Text(character.name)
                Text(character.status.rawValue)
                Text(character.species)
                // Adicione mais detalhes conforme necessário
            } else {
                Text("Carregando...")
            }
        }
        .padding()
        .onAppear {
            viewModel.getCharacterDetails(id: characterId)
        }
    }
}
