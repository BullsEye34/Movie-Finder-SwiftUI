//
//  MovieDetailView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct MovieDetailView: View {
    let id: Int
    @ObservedObject private var movieDetailState = MovieDetailsState()
    
    var body: some View {
        ZStack{
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.id)
            }
            if self.movieDetailState.movie != nil{
                MovieDetailsListView(movie: self.movieDetailState.movie!)
            }
        }
        .navigationTitle(self.movieDetailState.movie?.title ?? "")
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .onAppear(){
            self.movieDetailState.loadMovie(id: self.id)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
                MovieDetailView(id: Movie.stubbedMovie.id)
        }
    }
}


struct MovieDetailsListView: View{
    
    let movie: Movie
    
    var body: some View{
        List{
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(.zero))
                .listRowSeparator(.hidden)
            
            HStack{
                Text (movie.genreText)
                Text (" · ")
                Text (movie.yearText)
                Text (movie.durationText)
            }
            .listRowSeparator(.hidden)
            
            Text(movie.overview)
                .listRowSeparator(.hidden)
            
            HStack{
                if !movie.ratingText.isEmpty{
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text (" · ")
                Text(movie.scoreText)
            }
            .listRowSeparator(.hidden)
            
            Divider()
                .listRowSeparator(.hidden)
        }
        
    }
}

struct MovieDetailImage: View{
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(.gray.opacity(0.3))
            if self.imageLoader.image != nil{
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear(){
            self.imageLoader.loadImage(with: imageURL)
        }
    }
}
