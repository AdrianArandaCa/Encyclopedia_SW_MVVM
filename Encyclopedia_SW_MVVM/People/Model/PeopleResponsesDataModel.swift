//
//  PeopleModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation

struct PeopleResponsesDataModel: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PersonResponsesDataModel]
    
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
        self.results = try container.decode([PersonResponsesDataModel].self, forKey: .results)
    }
}

struct PersonResponsesDataModel: Decodable, Hashable {
    let name: String?
    let height: String?
    let mass: String?
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld: String?
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String?
    let edited: String?
    let url: String?
    
    enum CodingKeys: CodingKey {
        case name
        case height
        case mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.height = try container.decodeIfPresent(String.self, forKey: .height)
        self.mass = try container.decodeIfPresent(String.self, forKey: .mass)
        self.hairColor = try container.decodeIfPresent(String.self, forKey: .hairColor)
        self.skinColor = try container.decodeIfPresent(String.self, forKey: .skinColor)
        self.eyeColor = try container.decodeIfPresent(String.self, forKey: .eyeColor)
        self.birthYear = try container.decodeIfPresent(String.self, forKey: .birthYear)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.homeworld = try container.decodeIfPresent(String.self, forKey: .homeworld)
        self.films = try container.decode([String].self, forKey: .films)
        self.species = try container.decode([String].self, forKey: .species)
        self.vehicles = try container.decode([String].self, forKey: .vehicles)
        self.starships = try container.decode([String].self, forKey: .starships)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
        self.edited = try container.decodeIfPresent(String.self, forKey: .edited)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
