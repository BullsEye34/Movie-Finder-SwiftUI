//
//  MovieSearchView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 22/01/23.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    var body: some View {
        NavigationView{
            List{
                SearchBarView(placeholderText: "Search Movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .listRowSeparator(.hidden)
                
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                    ForEach(self.movieSearchState.movies!){ movie in
                        NavigationLink(destination: MovieDetailView(id: movie.id)){
                            VStack (alignment: .leading){
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .onAppear(){
                self.movieSearchState.startObserve()
            }
            .navigationTitle("Search Movies")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
