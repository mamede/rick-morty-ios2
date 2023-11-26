//
//  DetailView.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel = CharacterDetailViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let characterId: Int
    @ObservedObject var RMviewModel: RickAndMortyViewModel
    
    var body: some View {
        VStack {
           Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Voltar")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            if let character = viewModel.character {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 370, height: 370)
                    HStack{
                        VStack(alignment: .leading) {
                            Text(character.name)
                            Text("Status: \(character.status.rawValue)")
                            Text("Specie: \(character.species)")
                        }
                        Spacer()
                        Button(action: {
                          if RMviewModel.favorites.contains(where: { $0.id == character.id }) {
                              RMviewModel.removeFromFavorites(character: character)
                          } else {
                              RMviewModel.addToFavorites(character: character)
                          }
                            
                      }) {
                          Image(systemName: RMviewModel.favorites.contains(where: { $0.id == character.id }) ? "heart.fill" : "heart")
                      }
                    }
                    Spacer()
                }.padding()
            } else {
                Text("Carregando...")
            }
        }
        .padding()
        .navigationBarBackButtonHidden(false)
        .onAppear {
            viewModel.getCharacterDetails(id: characterId)
        }
    }
}
