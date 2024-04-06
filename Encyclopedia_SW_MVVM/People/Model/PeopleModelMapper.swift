//
//  PeopleModelMapper.swift
//  Encyclopedia_SW_MVVM
//
//  Created by Dev on 6/4/24.
//

import Foundation

struct PeopleModelMapper {
    func mapDataModelToModel(dataModel: PersonResponsesDataModel, homeworld: PlanetInfo, films: [FilmInfo], imageURL: GoogleResponsesDataModel? = nil) -> PersonModel? {
        return PersonModel(name: dataModel.name,
                           height: dataModel.height,
                           mass: dataModel.mass,
                           gender: dataModel.gender,
                           homeworld: dataModel.homeworld,
                           films: dataModel.films,
                           homeworldInfo: homeworld,
                           filmsInfo: films,
                           image: imageURL?.items.first)
    }
}
