//
//  ViewModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation
enum CustomError:String, Error {
    case error = "Error"
}

final class PeopleViewModel: ObservableObject {
    @Published var filmsInfo: FilmsModel?
    @Published var peopleInfo: [PersonModel]?
    @Published var planetsInfo: PlanetsModel?
    @Published var speciesInfo: SpeciesModel?
    @Published var vehiclesInfo: VehiclesModel?
    @Published var starshipsInfo: StarshipsModel?
    @Published var peopleResponsesDataModel: PeopleResponsesDataModel?
    @Published var showLoading = false
    @Published var showLoadingCharacter = false
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func getPeopleData() async {
        showLoading = true
        Task {
            do {
//                filmsInfo = await apiClient.getFilms()
                peopleResponsesDataModel = await apiClient.getPeople()
                if let peopleResponsesDataModel = peopleResponsesDataModel {
                    peopleInfo = await apiClient.getPeopleModel(peopleResponsesDataModel: peopleResponsesDataModel)
                }
//                setPersonsInfo()
//                planetsInfo = await apiClient.getPlanets()
//                speciesInfo = await apiClient.getSpecies()
//                vehiclesInfo = await apiClient.getVehicles()
//                starshipsInfo = await apiClient.getStarships()
            } catch let error as CustomError {
                print(error)
            }
            showLoading = false
        }
    }
    
    @MainActor
    func loadMorePeople() async {
        showLoading = true
        Task {
            do {
                let morePeople = await apiClient.getMorePeople(url: peopleResponsesDataModel?.next ?? nil)
                if morePeople != nil {
                    self.peopleResponsesDataModel = morePeople
                    if let personResponsesDataModel = self.peopleResponsesDataModel?.results {
                        peopleInfo?.append(contentsOf: await apiClient.getAllData(personResponsesDataModel: personResponsesDataModel))
                    }
                }
            } catch let error as CustomError {
                print(error)
            }
            showLoading = false
        }
    }
    
    func isLastItem(person: PersonModel) -> Bool {
        guard let index = self.peopleInfo?.firstIndex(where: { $0.name == person.name }) else { return false }
        return index == (peopleInfo?.count ?? 0) - 1
    }
}
