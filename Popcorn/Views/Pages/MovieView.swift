//
//  HomeView.swift
//  Popcorn
//
//  Created by Ettore Toma on 05/05/2023.
//

import SwiftUI

struct MovieView: View {
    
    @State var id: Int = 0
    
    @State var movie: Movie = Movie(id: 1, title: "asd", release_date: "asd")
    
    
    func GetMovieFromID(id: Int) async {
        let res =  await API().FetchMovieFromID(id: id)
        movie = res
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertedDate = dateFormatter.date(from: movie.release_date)
        
        if dateFormatter.date(from: movie.release_date) == nil {
               print("no date")
                movie.release_date = ""
                
        } else {
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let timeStamp = dateFormatter.string(from: convertedDate!)
            movie.release_date = timeStamp
        }
    }
    
    
    var body: some View {

        ScrollView {
            Text(movie.title)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.poster_path ?? "")")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height / 2)
                } placeholder: {
                    Rectangle()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height / 2)
                }
                .padding(.bottom, 20)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                HStack {
                                    Text("Average vote: ")
                                        .font(.callout)
                                    Text(String(movie.vote_average ?? 0.0))
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 10)
                                HStack {
                                    Text("Release date: ")
                                        .font(.callout)
                                    Text(movie.release_date)
                                        .fontWeight(.bold)
                                }
                                .padding(.bottom, 10)
                            }
                            .padding(.horizontal, 10)
                            .cornerRadius(20)
                            .background(Color(red: 245 / 255, green: 239 / 255, blue: 231 / 255))
                            
                            HStack(alignment: .center) {
                                Button {
                                    print("ok")
                                } label: {
                                    VStack {
                                        Image(systemName: "plus.circle")
                                        Text("to watchlist")
                                    }
                                    
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                    }
                    
                    
                    Text(movie.overview ?? "no description available")
                    
                }
                .padding(.horizontal, 10)
                    
                    Spacer()
                }
            .onAppear {
                            Task {
                                await GetMovieFromID(id: id)
                            }
                    }
            }
        }
    }

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(id: 387426, title: "Okja", release_date: "1234"))
    }
}
