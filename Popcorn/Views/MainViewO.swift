//
//  ContentView.swift
//  Popcorn
//
//  Created by Ettore Toma on 04/05/2023.
//

import SwiftUI
import UIKit

struct Quote: Codable {
        
        internal init(quote_id: Int, quote: String, author: String, series: String) {
            self.quote_id = quote_id
            self.quote = quote
            self.author = author
            self.series = series
        }
        
        var quote_id: Int
        var quote: String
        var author: String
        var series: String
    }

struct MainViewO: View {
    
    @State var text = "ok"
    @State var isOn = true
    
    @State var date = Date()
    
    @State private var quotes = [Quote]()
    
    func randRGB() -> Double {
        let num = Double.random(in: 0...1)
        return num
    }
    
    func fetchData() async {
                //create url
                guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
                    print("NOT WORK")
                    return
                }
                // fetch data from that url
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let decodeResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                        quotes = decodeResponse
                        print(quotes)
                        
                    }
                } catch {
                    print("BAD NEWS")
                }
            }
        
        
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://moviesdatabase.p.rapidapi.com/titles/search/keyword/avatar")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error as Any)
//            } else {
//                let movies = try JSONDecoder().decode(Movies.self, from: data!).results
//                print(movies)
//            }
//
//        })
        
        
    
    

    
    func getColour() -> Color {
        let colour = Color(red: randRGB(), green: randRGB(), blue: randRGB(), opacity: randRGB())
        return colour
    }
    
    var body: some View {
        NavigationStack{
            VStack {
//                DatePicker("date", selection: $date).frame(width: 50, height: 50, alignment: .center)
//                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
//                    .frame(width: 100, height: 100, alignment: .center)
////                    .size(width: 50, height: 50)
//                    .foregroundColor(getColour())
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//                Text(text).padding(10)
                Button(action: {
                    isOn.toggle()
//                    getMovies()
                    
                }, label: {
                    Label("Get movies", systemImage: "popcorn.circle")
                })

//                List(movies, id: \.page) { movie in
//                    Text(movie.results[0])
//                }
//                NavigationLink(destination: HomeView(), label: {
//                    Label("go", systemImage: "folder")
//                })
//                .padding(20)
            }
            .task {
                await fetchData()
            }
        }
        
    }
}

struct MainViewO_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
