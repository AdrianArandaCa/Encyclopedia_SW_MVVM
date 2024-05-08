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
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    if let people = viewModel.peopleInfo {
                        ForEach(people, id: \.name) { person in
                            NavigationLink(destination: CharacterDetail(characterInfo: person)) {
                                Text(person.name ?? "")
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
                }
                .navigationTitle("Star Wars")
                .navigationBarTitleDisplayMode(.large)
                .background(.white)
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
        ZStack {
            VStack {
                if let url = characterInfo?.image?.link {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                } else {
                    Image("siluette")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(100)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                    
                }
                Text(characterInfo?.name ?? "")
                Text(characterInfo?.height ?? "")
                Text(characterInfo?.mass ?? "")
                Text(characterInfo?.gender ?? "")
                Text(characterInfo?.homeworldInfo?.name ?? "")
                List {
                    ForEach(characterInfo?.filmsInfo ?? [], id: \.episodeId) { film in
                        Text("Pelicula: \(film.title)")
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
