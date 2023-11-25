//
//  ContentView.swift
//  Rick morty IOS 2
//
//  Created by Felipe Mamede on 25/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RickAndMortyViewModel()
    @State private var searchText = "" // Adiciona um estado para o texto de pesquisa
    
    var body: some View {
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
                
                List(viewModel.data.filter {
                    searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                }, id: \.name) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 70, height: 70)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.status.rawValue)
                            Text(item.species)
                        }
                        Spacer()
                        Button(action: {
                            print("Coração pressionado!")
                        }) {
                            Image(systemName: "heart")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    viewModel.getData()
                }
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Personagens")
            }
            
            RMFavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
