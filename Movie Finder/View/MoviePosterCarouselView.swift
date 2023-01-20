//
//  MoviePosterCarouselView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    let title: String
    let movies : [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        MoviePosterCard(movie: movie)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct MoviePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarouselView(title:"Trending", movies: Movie.stubbedMovies)
    }
}
