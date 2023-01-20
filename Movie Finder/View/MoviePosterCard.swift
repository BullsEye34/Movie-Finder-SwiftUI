//
//  MoviePosterCard.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct MoviePosterCard: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack{
            if(self.imageLoader.image != nil){
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4, x: 0, y: 0)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4, x: 0, y: 0)
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 204, height: 306)
        .onAppear(){
            self.imageLoader.loadImage(with: movie.posterURL)
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
