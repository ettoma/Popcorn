//
//  MainView.swift
//  Popcorn
//
//  Created by Ettore Toma on 18/05/2023.
//

import SwiftUI

struct MainView: View {
    
    func GetMovieFromKeyword(keyword: String) async   {
        
        let res =  await API().FetchMovieFromKeyword(keyword: input)
        
        movies = res
    }
    
    @State var input: String = ""
    
    @State var movies: [Movie] = []
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: UIScreen.main.bounds.width * 3, height: 400)
                    .rotationEffect(Angle(degrees: 15))
                    .offset(y: -100)

                    Form {
                        TextField(
                            "Enter a keyword",
                            text: $input)
                        
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    }
                    .onSubmit {
                        Task {
                                                           await GetMovieFromKeyword(keyword: input)
                                                    }
                    }
                    .cornerRadius(20)
                    .offset(y: -50)
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 150)
                }

            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(movies) { movie in
                        MovieCard(title: movie.Title, poster: movie.Poster)
                    }
                }

            }

            Spacer()
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
