//
//  PlanetsModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation

struct PlanetsModel: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetModel]
    
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
        self.results = try container.decode([PlanetModel].self, forKey: .results)
    }
}

struct PlanetModel: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        self.orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        self.diameter = try container.decode(String.self, forKey: .diameter)
        self.climate = try container.decode(String.self, forKey: .climate)
        self.gravity = try container.decode(String.self, forKey: .gravity)
        self.terrain = try container.decode(String.self, forKey: .terrain)
        self.surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
        self.population = try container.decode(String.self, forKey: .population)
        self.residents = try container.decode([String].self, forKey: .residents)
        self.films = try container.decode([String].self, forKey: .films)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}
struct PlanetInfo {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    
    static var empty: Self {
        .init(name: "", rotationPeriod: "", orbitalPeriod: "", diameter: "", climate: "", gravity: "", terrain: "", surfaceWater: "", population: "")
    }
}


