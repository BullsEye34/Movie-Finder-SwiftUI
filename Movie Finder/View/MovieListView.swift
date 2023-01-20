//
//  MovieListView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var trendingMoviesState = MovieListState()
    @ObservedObject private var upcomingMoviesState = MovieListState()
    @ObservedObject private var topRatedMoviesState = MovieListState()
    @ObservedObject private var popularMoviesState = MovieListState()
    
    var body: some View {
        NavigationView {
            List{
                Group{
                    if trendingMoviesState.movies != nil{
                        MoviePosterCarouselView(title: "Trending Now", movies: trendingMoviesState.movies!)
                    }else{
                        LoadingView(isLoading: trendingMoviesState.isLoading, error: trendingMoviesState.error) {
                            self.trendingMoviesState.loadMovies(with: .trending)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
                
                Group{
                    if upcomingMoviesState.movies != nil{
                        MovieBackdropCarouselView(title: "Upcoming Movies", movies: upcomingMoviesState.movies!)
                    }else{
                        LoadingView(isLoading: upcomingMoviesState.isLoading, error: upcomingMoviesState.error) {
                            self.upcomingMoviesState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
                
                Group{
                    if topRatedMoviesState.movies != nil{
                        MovieBackdropCarouselView(title: "Top Rated Movies", movies: topRatedMoviesState.movies!)
                    }else{
                        LoadingView(isLoading: topRatedMoviesState.isLoading, error: topRatedMoviesState.error) {
                            self.topRatedMoviesState.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
                
                Group{
                    if popularMoviesState.movies != nil{
                        MovieBackdropCarouselView(title: "Most Popular Movies", movies: popularMoviesState.movies!)
                    }else{
                        LoadingView(isLoading: popularMoviesState.isLoading, error: popularMoviesState.error) {
                            self.popularMoviesState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Movie Finder")
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear(){
            self.trendingMoviesState.loadMovies(with: .trending)
            self.upcomingMoviesState.loadMovies(with: .upcoming)
            self.topRatedMoviesState.loadMovies(with: .topRated)
            self.popularMoviesState.loadMovies(with: .popular)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
