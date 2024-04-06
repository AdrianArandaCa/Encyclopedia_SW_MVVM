//
//  StarshipsModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation

struct StarshipsModel: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarshipModel]
    
    enum CodingKeys: CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous)
        self.results = try container.decode([StarshipModel].self, forKey: .results)
    }
    
}

struct StarshipModel: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let hyperdriveRating: String
    let MGLT: String
    let starshipClass: String
    let pilots: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.model = try container.decode(String.self, forKey: .model)
        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
        self.costInCredits = try container.decode(String.self, forKey: .costInCredits)
        self.length = try container.decode(String.self, forKey: .length)
        self.maxAtmospheringSpeed = try container.decode(String.self, forKey: .maxAtmospheringSpeed)
        self.crew = try container.decode(String.self, forKey: .crew)
        self.passengers = try container.decode(String.self, forKey: .passengers)
        self.cargoCapacity = try container.decode(String.self, forKey: .cargoCapacity)
        self.consumables = try container.decode(String.self, forKey: .consumables)
        self.hyperdriveRating = try container.decode(String.self, forKey: .hyperdriveRating)
        self.MGLT = try container.decode(String.self, forKey: .MGLT)
        self.starshipClass = try container.decode(String.self, forKey: .starshipClass)
        self.pilots = try container.decode([String].self, forKey: .pilots)
        self.films = try container.decode([String].self, forKey: .films)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case MGLT
        case starshipClass = "starship_class"
        case pilots
        case films
        case created
        case edited
        case url
    }
}

