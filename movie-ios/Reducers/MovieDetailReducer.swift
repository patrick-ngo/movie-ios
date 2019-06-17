//
//  MovieDetailReducer.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import ReSwift

struct MovieDetailState: Equatable {
    var selectedMovie: MovieModel?
    var relatedMovies: [MovieModel]?
}

func movieDetailReducer(action: Action, state: MovieDetailState?) -> MovieDetailState {
    // Create the default state if no state provided
    var state = state ?? MovieDetailState()
    
    switch action {
    case let action as SetSelectedMovie:
        state.selectedMovie = action.movie
    case let action as SetRelatedMovies:
        state.relatedMovies = action.relatedMovies
        
    default:
        break
    }
    
    return state
}
