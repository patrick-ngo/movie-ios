//
//  MovieDetailActions.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct SetSelectedMovie: Action {
    let movie: MovieModel
}

struct SetRelatedMovies: Action {
    let relatedMovies: [MovieModel]
}

let fetchRelatedMovies = Thunk<AppState> { dispatch, getState in
    guard let state = getState()?.movieDetailState, let movieId = state.selectedMovie?.id else { return }
    
    MoviesAPI.shared.retrieveRelatedMovies(byId: movieId) { (result, error) in
        if let result = result, error == nil {
            do {
                let moviesResponse = try JSONDecoder().decode(MovieListModel.self, from: result)
        
                var movieList: [MovieModel] = []
                // Set list of movies
                if let movies = moviesResponse.results {
                    movieList = movies
                }
                dispatch(SetRelatedMovies(relatedMovies: movieList))
            }
            catch let error {
                print("Error: \(error)")
            }
        }
    }
}
