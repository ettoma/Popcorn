//
//  MovieCardView.swift
//  Popcorn
//
//  Created by Ettore Toma on 23/05/2023.
//

import SwiftUI

struct MovieCard: View {
    
    var  title: String
    var  poster: String
    var movieID: Int
    var voteAverage: Float

    
    var body: some View {
        ZStack {
            NavigationLink(destination: MovieView(id: movieID), label: {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(poster)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 300, maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    Rectangle()
                        .scaledToFill()
                        .frame(maxWidth: 300, maxHeight: 200)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius:10))
                }
            })
            
            VStack {
                Spacer()
                HStack {
                    VStack {
                        Text(title)
                        HStack {
                            Image(systemName: "star.fill")
                            Text(voteAverage != 0 ? String(format: "%.1f", voteAverage) : "n/a")
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .font(.title3)
                .fontWeight(.heavy)
                .frame(width: 300, height: 80)
                .background(Color.black.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius:10))
            }
            .frame(maxWidth: 300, maxHeight: 200)
        }
        
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(title: "", poster: "", movieID: 0, voteAverage: 0)
    }
}
