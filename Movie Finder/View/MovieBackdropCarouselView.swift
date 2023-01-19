//
//  MovieBackdropCarouselView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    let title: String
    let movies: [Movie]
    var body: some View {
        VStackLayout(alignment: .leading, spacing: .zero){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        MovieBackdropView(movie: movie)
                            .frame(width: 272, height: 200)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct MovieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouselView(title: "Trending", movies: Movie.stubbedMovies)
    }
}
