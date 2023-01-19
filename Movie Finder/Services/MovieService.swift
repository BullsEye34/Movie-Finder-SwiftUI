//
//  MovieService.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import Foundation

protocol MovieService{
    func fetchMovies(from endpoint: MovieListEndpoints, completion: @escaping (Result<MovieResponse, MovieError>) ->())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) ->())
    func searchMovies(query: String, completion: @escaping (Result<MovieResponse, MovieError>) ->())
    
}

enum MovieListEndpoints: String, CaseIterable{
    case trending = "trending"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description : String{
        switch self{
        case .trending : return "Trending"
        case .upcoming : return  "Upcoming"
        case .topRated : return "Top Rated"
        case .popular : return "Popular"
        }
    }
}


enum MovieError: Error, CustomNSError{
    case apiError
    case invalidEndPointError
    case invalidResponseError
    case noDataError
    case serializationError
    
    var localisedDescription: String{
        switch self{
        case .apiError: return "Failed to Fetch Data"
        case .invalidEndPointError: return "Invalid Endpoint"
        case .invalidResponseError: return "Invalid Response"
        case .noDataError: return "No data"
        case .serializationError: return "Failed to Decode Data"
        }
    }
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localisedDescription]
    }
}
