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
    
    var body: some View {
        VStack {
            Text(title)
            AsyncImage(url: URL(string: poster), scale: 2)
                                .padding(20)
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(title: "", poster: "")
    }
}
