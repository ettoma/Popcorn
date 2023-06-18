//
//  HomeView.swift
//  Popcorn
//
//  Created by Ettore Toma on 04/06/2023.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore


struct HomeView: View {

    func GetMovieFromKeyword(keyword: String) async   {
        let res =  await API().FetchMovieFromKeyword(keyword: input)
        movies = res
    }
    
    
    @State var input: String = ""
    
    @State var movies: [Movie] = []
    
    var body: some View {
        VStack(alignment: .center) {
                TextField("Movies", text: $input, prompt: Text("Enter a keyword"))
                    .onChange(of: input, perform: { searchString in
                        
                        if searchString.count > 3 {
                            Task {
                                await GetMovieFromKeyword(keyword: searchString)
                            }
                        } else if searchString.count == 0 {
                            movies = []
                        }
                        
                    }
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(width: UIScreen.main.bounds.width * 0.75, height: 100)
                    
            
            if movies.isEmpty == true && input.count > 3 {
                Text("no results")
            } else if movies.isEmpty == true && input.count <= 3 {
                Text("start looking for a movie now")
            } else if movies.isEmpty == false {
                ScrollView {
                    VStack {
                        ForEach(movies) { movie in
                            MovieCard(title: movie.title, poster: movie.poster_path ?? "", movieID: movie.id, voteAverage: movie.vote_average ?? 0)
                        }
                    }
                }
            } else {
                Text("error")
            }

        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
