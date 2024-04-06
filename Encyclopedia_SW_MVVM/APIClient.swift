//
//  APIClient.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation

//enum BackendError: String, Error {
//    case invalidEmail = "Comprueba el email"
//    case invalidPassword = "Comprueba el password"
//}

//MARK: APIKEY google AIzaSyB18sZwdSmtsA7gY3TO1rkC082zUBpMIVA
//MARK: Llamada google -> GET
// https://www.googleapis.com/customsearch/v1?key=AIzaSyB18sZwdSmtsA7gY3TO1rkC082zUBpMIVA&cx=633e1cf8fb8da44bc&q=han%20solo&searchType=image
// https://www.googleapis.com/customsearch/v1?key=AIzaSyB18sZwdSmtsA7gY3TO1rkC082zUBpMIVA&cx=633e1cf8fb8da44bc&q=LukeSkywalker&searchType=image"

final class APIClient {
    
    private let baseUrl = "https://swapi.dev/api/"
    
    private let baseGoogleUrl = "https://www.googleapis.com/customsearch/v1"
    private let googleApi = "AIzaSyB18sZwdSmtsA7gY3TO1rkC082zUBpMIVA"
    private let cx = "633e1cf8fb8da44bc"
    private let peopleModelMapper: PeopleModelMapper = PeopleModelMapper()
    
    //MARK: Repo google api
    
    func getImage(imageName: String) async -> GoogleResponsesDataModel? {
        let imageNameWithoutSpaces = imageName.replacingOccurrences(of: " ", with: "")
        let url = String(format:"%@?key=%@&cx=%@&q=%@&searchType=image",
                         baseGoogleUrl, googleApi, cx, imageNameWithoutSpaces)
        if let imageURL = URL(string: url) {
            if let (data,_) = try? await URLSession.shared.data(from: imageURL) {
                let googleResponsesDataModel = try? JSONDecoder().decode(GoogleResponsesDataModel.self, from: data)
                return googleResponsesDataModel
            }
        }
        return nil
    }
    //MARK: Repo people
    
    func getPeople() async -> PeopleResponsesDataModel? {
        let urlPeople = "people/"
        if let peopleURL = URL(string: String(format: "%@%@", baseUrl,urlPeople)) {
            let (data,_) = try! await URLSession.shared.data(from: peopleURL)
            let peopleResponsesDataModel = try? JSONDecoder().decode(PeopleResponsesDataModel.self, from: data)
            print("People response: \(peopleResponsesDataModel!)")
            return peopleResponsesDataModel
        }
        return nil
    }
    
    func getPeopleModel(peopleResponsesDataModel: PeopleResponsesDataModel) async -> [PersonModel] {
        var peopleModel = [PersonModel]()
        let people = peopleResponsesDataModel.results
        peopleModel.append(contentsOf: await getAllData(personResponsesDataModel: people))
        return peopleModel
    }
    
    func getMorePeople(url: String?) async -> PeopleResponsesDataModel? {
        if let url = url {
            if let peopleURL = URL(string: url) {
                let (data, _) = try! await URLSession.shared.data(from: peopleURL)
                let peopleModel = try? JSONDecoder().decode(PeopleResponsesDataModel.self, from: data)
                print("People response: \(peopleModel!)")
                return peopleModel
            }
            return nil
        } else {
            return nil
        }
    }
    
    func getAllData(personResponsesDataModel: [PersonResponsesDataModel]) async -> [PersonModel] {
        var peopleModel = [PersonModel]()
        for person in personResponsesDataModel {
            if let homeworldData = await gethomeworldData(homeworldURL: person.homeworld ?? "") {
                if let films = await getFilmsData(films: person.films) {
                    if let imageURL = await getImage(imageName: person.name ?? "") {
                        if let peopleModelMapper = peopleModelMapper.mapDataModelToModel(dataModel: person, homeworld: homeworldData, films: films, imageURL: imageURL) {
                            peopleModel.append(peopleModelMapper)
                        }
                    } else {
                        if let peopleModelMapper = peopleModelMapper.mapDataModelToModel(dataModel: person, homeworld: homeworldData, films: films) {
                            peopleModel.append(peopleModelMapper)
                        }
                    }
                }
            }
        }
        return peopleModel
    }
    
    
    //MARK: Repo Films
    
    func getFilms() async -> FilmsModel? {
        let urlFilms = "films/"
        if let filmURL = URL(string: String(format: "%@%@", baseUrl,urlFilms)) {
            let (data,_) = try! await URLSession.shared.data(from: filmURL)
            let filmsModel = try? JSONDecoder().decode(FilmsModel.self, from: data)
            print("Films response: \(filmsModel!)")
            return filmsModel
        }
        return nil
    }
    
    func getFilmsData(films: [String]) async -> [FilmInfo]? {
    var filmsInfo = [FilmInfo]()
        for film in films {
            if let filmURL = URL(string: film) {
                let (data,_) = try! await URLSession.shared.data(from: filmURL)
                let filmModel = try! JSONDecoder().decode(FilmModel.self, from: data)
                filmsInfo.append(FilmInfo.init(title: filmModel.title,
                                               episodeId: NSNumber(value: filmModel.episodeId),
                                               openingCrawl: filmModel.openingCrawl,
                                               director: filmModel.director,
                                               producer: filmModel.producer,
                                               releaseDate: filmModel.releaseDate))
                print("\(filmModel)")
            }
        }
        return filmsInfo
    }
    
    //MARK: Repo Homeworld
    
    func gethomeworldData(homeworldURL: String?) async -> PlanetInfo? {
        var homeworldInfo: PlanetInfo?
        if let homeworldURL = homeworldURL, let homeworldURL = URL(string: homeworldURL) {
            let (data,_) = try! await URLSession.shared.data(from: homeworldURL)
            let homeworldModel = try! JSONDecoder().decode(PlanetModel.self, from: data)
            homeworldInfo = PlanetInfo(name: homeworldModel.name,
                                       rotationPeriod: homeworldModel.rotationPeriod,
                                       orbitalPeriod: homeworldModel.orbitalPeriod,
                                       diameter: homeworldModel.diameter,
                                       climate: homeworldModel.climate,
                                       gravity: homeworldModel.gravity,
                                       terrain: homeworldModel.terrain,
                                       surfaceWater: homeworldModel.surfaceWater,
                                       population: homeworldModel.population)
            print("\(homeworldModel)")
            return homeworldInfo
        }
        return homeworldInfo
    }
    
    //MARK: Repo Planets
    
    func getPlanets() async -> PlanetsModel? {
        let urlPlanets = "planets/"
        if let planetsURL = URL(string: String(format: "%@%@", baseUrl,urlPlanets)) {
            let (data,_) = try! await URLSession.shared.data(from: planetsURL)
            let planetsModel = try? JSONDecoder().decode(PlanetsModel.self, from: data)
            print("Planets response: \(planetsModel!)")
            return planetsModel
        }
        return nil
    }
    
    //MARK: Repo Species
    
    func getSpecies() async -> SpeciesModel? {
        let urlSpecies = "species/"
        if let speciesURL = URL(string: String(format: "%@%@", baseUrl,urlSpecies)) {
            let (data,_) = try! await URLSession.shared.data(from: speciesURL)
            let speciesModel = try? JSONDecoder().decode(SpeciesModel.self, from: data)
            print("Species response: \(speciesModel!)")
            return speciesModel
        }
        return nil
    }
    
    //MARK: Repo Starships
    
    func getStarships() async -> StarshipsModel? {
        let urlStarships = "starships/"
        if let starshipsURL = URL(string: String(format: "%@%@", baseUrl,urlStarships)) {
            let (data,_) = try! await URLSession.shared.data(from: starshipsURL)
            let starshipsModel = try? JSONDecoder().decode(StarshipsModel.self, from: data)
            print("Starships response: \(starshipsModel!)")
            return starshipsModel
        }
        return nil
    }
    
    //MARK: Repo Vehicles
    
    func getVehicles() async -> VehiclesModel? {
        let urlVehicles = "vehicles/"
        if let vehiclesURL = URL(string: String(format: "%@%@", baseUrl,urlVehicles)) {
            let (data,_) = try! await URLSession.shared.data(from: vehiclesURL)
            let vehiclesModel = try? JSONDecoder().decode(VehiclesModel.self, from: data)
            print("Vehicles response: \(vehiclesModel!)")
            return vehiclesModel
        }
        return nil
    }
}
