//
//  ContentView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 19/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            MovieListView()
                .tabItem {
                    VStack{
                        Image(systemName: "tv")
                        Text("Movies")
                    }
                }
                .tag(0)
            MovieSearchView()
                .tabItem {
                    VStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
