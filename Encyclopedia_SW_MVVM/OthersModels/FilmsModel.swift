//
//  FilmsModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 26/11/23.
//

import Foundation

struct FilmsModel: Decodable {
    let count: Int
    let next : String?
    let previous : String?
    let results : [FilmModel]
    
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
        self.results = try container.decode([FilmModel].self, forKey: .results)
    }
}

struct FilmModel: Decodable {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
    let starships: [String]
    let vehicles: [String]
    let species: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case planets
        case starships
        case vehicles
        case species
        case created
        case edited
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.episodeId = try container.decode(Int.self, forKey: .episodeId)
        self.openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
        self.director = try container.decode(String.self, forKey: .director)
        self.producer = try container.decode(String.self, forKey: .producer)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.characters = try container.decode([String].self, forKey: .characters)
        self.planets = try container.decode([String].self, forKey: .planets)
        self.starships = try container.decode([String].self, forKey: .starships)
        self.vehicles = try container.decode([String].self, forKey: .vehicles)
        self.species = try container.decode([String].self, forKey: .species)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

struct FilmInfo {
    let title: String
    let episodeId: NSNumber
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    
    static var empty: Self {
        .init(title: "", episodeId: 0, openingCrawl: "", director: "", producer: "", releaseDate: "")
    }
}
