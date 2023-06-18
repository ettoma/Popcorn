//
//  WatchlistView.swift
//  Popcorn
//
//  Created by Ettore Toma on 04/06/2023.
//

import SwiftUI

struct WatchlistView: View {
    
    @State var movies: [Movie] = []
    @State var watchedMovies: [Movie] = []
    @State var toWatchMovies: [Movie] = []
    
    func GetWatchlist() async   {
        
        var moviesIDs =  await API().GetWatchlist()

        for id in moviesIDs {
            do {
                let movie = await API().FetchMovieFromID(id: id)
                movies.append(movie)
                
                if movie.id == 38274 {
                    watchedMovies.append(movie)
                }
            }
        }

    }
    var body: some View {

                List(movies) { movie in
                    MovieRow(movie: movie)
                }
        .onAppear() {
            Task {
                if movies.isEmpty != true {
                    return
                } else {
                    await GetWatchlist()
                }
            }
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}

struct MovieRow: View {
    @State var movie: Movie
    @State private var isOn = false
    
    var body: some View {
        HStack {
            NavigationLink(destination: MovieView(id: movie.id), label: {
                Text(movie.title)
                
            })
            Toggle(isOn: $isOn) {
                Text("on")
            }
            .toggleStyle(CheckboxToggleStyle())
            
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
 
            configuration.label
 
        }
    }
}
