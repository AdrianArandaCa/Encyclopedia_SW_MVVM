//
//  PersonModel.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 6/4/24.
//

import Foundation

struct PersonModel {
    
    var name: String?
    var height: String?
    var mass: String?
    var gender: String?
    var homeworld: String?
    var films: [String]?
    var homeworldInfo: PlanetInfo?
    var filmsInfo: [FilmInfo]
    var image: Item?
    
    static var empty: Self {
        .init(name: "No name", height: "No height", mass: "No mass", gender: "No gender", homeworld: "No homeworld" , films: [], homeworldInfo: PlanetInfo.empty, filmsInfo: [])
    }
    
}
