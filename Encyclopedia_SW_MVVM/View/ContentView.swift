//
//  ContentView.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PeopleViewModel(apiClient: APIClient())
    @State var isLoading : Bool = false
    @State private var searchText = ""
    
    var filteredCharacters: [PersonModel] {
        if let peopleInfo = viewModel.peopleInfo {
            guard !searchText.isEmpty else { return peopleInfo }
            return peopleInfo.filter({ $0.name.localizedCaseInsensitiveContains(searchText) })
        }
        return []
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(filteredCharacters, id: \.name) { person in
                        NavigationLink(destination: CharacterDetail(characterInfo: person)) {
                            Text(person.name)
                                .onAppear {
                                    if viewModel.isLastItem(person: person) {
                                        Task {
                                            await viewModel.loadMorePeople()
                                        }
                                    }
                                }
                        }.onAppear {
                            
                        }
                    }
                }
                .navigationTitle("Characters")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $searchText, prompt: "Search character")
            }
            .overlay(
                viewModel.showLoading ? AnyView(ProgressView()) : AnyView(EmptyView()),
                alignment: .center
            )
            .onAppear{
                Task {
                    await viewModel.getPeopleData()
                }
                
            }
        }
    }
}

struct CharacterDetail: View {
    var characterInfo: PersonModel?
    var body: some View {
        VStack {
            if let url = characterInfo?.image?.link {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
            } else {
                Image("siluette")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(100)
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
            }
            HStack {
                Text("Name: ")
                Spacer()
                Text(characterInfo?.name ?? "")
            }.padding(.bottom, 5)
            
            HStack {
                Text("Height: ")
                Spacer()
                Text(characterInfo?.height ?? "")
            }.padding(.bottom, 5)
            
            HStack {
                Text("Mass: ")
                Spacer()
                Text(characterInfo?.mass ?? "")
            }.padding(.bottom, 5)
            
            HStack {
                Text("Gender: ")
                Spacer()
                Text(characterInfo?.gender ?? "")
            }.padding(.bottom, 5)
            
            HStack {
                Text("Homeworld: ")
                Spacer()
                Text(characterInfo?.homeworldInfo?.name ?? "")
            }.padding(.bottom, 5)
            
            NavigationStack {
                ZStack {
                    Color.white.ignoresSafeArea()
                    List {
                        ForEach(characterInfo?.filmsInfo ?? [], id: \.episodeId) { film in
                            Text("\(film.title)")
                        }
                    }
                    .navigationTitle("Films")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .scrollContentBackground(.hidden)
            Spacer()
        }
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


