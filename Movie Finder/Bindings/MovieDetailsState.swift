//
//  MovieDetailsState.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

class MovieDetailsState: ObservableObject{
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func loadMovie(id: Int){
        self.isLoading = false
        self.movie = nil
        self.movieService.fetchMovie(id: id) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result{
            case .success(let response):
                self.movie = response
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
