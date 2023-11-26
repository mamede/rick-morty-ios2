//
//  ContentView.swift
//  RickMortyIOS2
//
//  Created by Felipe Mamede on 25/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RickAndMortyViewModel()
    @State private var searchText = "" // Adiciona um estado para o texto de pesquisa

    var body: some View {
      NavigationView {
        TabView {
          VStack {
            Text("Personagens")
                .font(.largeTitle)
                .padding()
              
            TextField("Buscar", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
              ScrollView {
                LazyVStack {
                    ForEach(viewModel.data.filter {
                        searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                    }, id: \.id) { item in
                        CharacterRow(item: item, viewModel: viewModel)
                    }.padding(.horizontal)
                }.onAppear {
                  viewModel.getData()
              }
              }.padding(.bottom)
          }
          .tabItem {
            Image(systemName: "person.3")
            Text("Personagens")
          }
          RMFavoritesView(viewModel: viewModel)
            .tabItem {
                Image(systemName: "heart")
                Text("Favoritos")
            }
          }
          .background(Color.white.ignoresSafeArea())
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
