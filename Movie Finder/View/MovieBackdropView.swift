//
//  MovieBackdropView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import SwiftUI

struct MovieBackdropView: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    var body: some View {
        VStack (alignment: .leading){
            ZStack{
                Rectangle()
                    .fill(.gray.opacity(0.3))
                if self.imageLoader.image != nil{
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9,contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4, x: 0, y: 0)
            Text(movie.title)
        }
        .onAppear{
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

struct MovieBackdropView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropView(movie: Movie.stubbedMovie)
    }
}
