//
//  MovieListModel.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

// Movie List
struct MovieListModel: Codable, Equatable {
    let page: Int?
    let results: [MovieModel]?
    let total_results: Int?
    let total_pages: Int?
}
