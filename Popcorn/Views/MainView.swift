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
        print(res)
        movieTitle = res[0]
        movieImage = res[1]
    }
    
    @State var input: String = ""
    
    @State var movieTitle: String = ""
    @State var movieImage: String = ""
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: UIScreen.main.bounds.width * 3, height: 400)
                    .rotationEffect(Angle(degrees: 15))
                    .offset(y: -100)
                HStack{
                    Form{
                        TextField(
                            "Enter a keyword",
                            text: $input)
                        
                        .padding(25)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        Button(
                            action: {
                                Task {
                                   await GetMovieFromKeyword(keyword: input)
                                }
                            },
                            label: {
                                Image(systemName: "magnifyingglass")
                            })
                        
                    }
                    .cornerRadius(20)
                    .offset(y: -50)
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 200)
                }

            }
            
            ScrollView {
                Text(movieTitle.isEmpty ? "" : movieTitle)
                    .bold()
                AsyncImage(url: URL(string: movieImage), scale: 1)
                    .padding(20)
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
