//
//  FavoriteView.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import SwiftUI

struct RMFavoritesView: View {
    @ObservedObject var viewModel: RickAndMortyViewModel
    
    private func removeFavorites(at offsets: IndexSet) {
        for index in offsets {
            let character = viewModel.favorites[index]
            viewModel.removeFromFavorites(character: character)
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Text("Favoritos")
                    .font(.largeTitle)
                    .padding()
                if viewModel.favorites.isEmpty {
                    Text("Você não tem nenhum favorito ainda.")
                        .font(.title)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.favorites, id: \.id) { character in
                                CharacterRow(item: character, viewModel: viewModel)
                            }
                            .onDelete(perform: removeFavorites)
                            .padding(.horizontal)
                        }.onAppear {
                            viewModel.getData()
                        }
                    }.padding(.bottom)
                }
            }
        }
    }
        struct CharacterRow: View {
            let item: RMCharacters
            @ObservedObject var viewModel: RickAndMortyViewModel
            
            var body: some View {
                NavigationLink(destination: DetailView(characterId: item.id, RMviewModel: viewModel)) {
                    HStack {
                        AsyncImage(url: URL(string: item.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading) {
                            Text(item.name).foregroundColor(.black)
                            Text(item.status.rawValue).foregroundColor(.black)
                            Text(item.species).foregroundColor(.black)
                        }
                        Spacer()
                        Button(action: {
                            if viewModel.favorites.contains(where: { $0.id == item.id }) {
                                viewModel.removeFromFavorites(character: item)
                            } else {
                                viewModel.addToFavorites(character: item)
                            }
                        }) {
                            Image(systemName: viewModel.favorites.contains(where: { $0.id == item.id }) ? "heart.fill" : "heart")
                        }
                    }
                }
            }
        }
    }

