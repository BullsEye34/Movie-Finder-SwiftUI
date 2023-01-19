//
//  MovieModel.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Decodable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Decodable {
    let id: Int
    let backdropPath: String
    let title: String
    let originalTitle, overview, posterPath: String
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
