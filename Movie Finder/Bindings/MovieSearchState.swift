//
//  MovieSearchState.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 22/01/23.
//

import Combine
import SwiftUI
import Foundation

class MovieSearchState: ObservableObject{
    @Published var query = ""
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func startObserve(){
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
        
            .map{[ weak self ] text in
                    self?.movies = nil
                    self?.error = nil
                    return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink {[weak self] in self?.search(query: $0)}
    }
    
    func search(query: String){
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        guard !query.isEmpty else{ return }
        
        self.isLoading = true
        self.movieService.searchMovies(query: query) { [weak self] (result) in
            guard let self = self, self.query == query else { return }
            self.isLoading = false
            
            switch result{
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        subscriptionToken?.cancel()
        subscriptionToken = nil
    }
}
