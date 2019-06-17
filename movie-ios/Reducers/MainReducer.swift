//
//  MainReducer.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct AppState: StateType, Equatable {
    var movieListState: MovieListState = MovieListState()
    var movieDetailState: MovieDetailState = MovieDetailState()
}


func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        movieListState: movieListReducer(action: action, state: state?.movieListState),
        movieDetailState: movieDetailReducer(action: action, state: state?.movieDetailState)
    )
}

let thunksMiddleware: Middleware<AppState> = createThunksMiddleware()

let mainStore = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: [thunksMiddleware]
)

