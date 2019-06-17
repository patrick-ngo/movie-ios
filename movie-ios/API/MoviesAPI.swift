//
//  MoviesAPI.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import Alamofire

typealias JSONCompletionBlock = ( [String:Any]? ,_ error: Error?) -> Void
typealias DataCompletionBlock = ( Data? ,_ error: Error?) -> Void

class MoviesAPI
{
    static let API_KEY = "e4a3bc287b929e12897dd730b1b153e9"
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
    static let CATHAY_URL = "https://www.cathaycineplexes.com.sg/"
    
    static let shared = MoviesAPI()
    
    //MARK: - API methods -
    
    // Retrieve list of movies
    func retrieveMovies(page: Int = 1, completionHandler: @escaping DataCompletionBlock) {
        let endPoint = "movie/now_playing"
        let url = URL(string: "\(MoviesAPI.BASE_URL)\(endPoint)")!
        let parameters: Parameters = ["page": page,
                                      "api_key": MoviesAPI.API_KEY]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            completionHandler(response.data, response.error)
        }
    }
    
    // Retrieve related movies by movie id
    func retrieveRelatedMovies(byId movieId: Int, completionHandler: @escaping DataCompletionBlock) {
        let endPoint = "movie/\(movieId)/similar"
        let url = URL(string: "\(MoviesAPI.BASE_URL)\(endPoint)")!
        let parameters: Parameters = ["api_key": MoviesAPI.API_KEY]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            completionHandler(response.data, response.error)
        }
    }
}

