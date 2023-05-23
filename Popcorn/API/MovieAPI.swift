//
//  MovieAPI.swift
//  Popcorn
//
//  Created by Ettore Toma on 18/05/2023.
//

import Foundation

let headers = [
    "X-RapidAPI-Key": ProcessInfo.processInfo.environment["API_KEY"],
    "X-RapidAPI-Host": "movie-database-alternative.p.rapidapi.com"
]

struct Movie: Identifiable, Codable {
    var imdbID: String
    var id: String { imdbID }
    var Title: String
    var Year: String
    var Poster: String
}

struct MovieSearch: Codable {
    var Response: String
    var TotalResults: String?
    var Search: [Movie]?
}


class API {
    func FetchMovieFromKeyword(keyword: String) async -> [Movie] {
        var result: [Movie] = []
        
        let searchKeyword = keyword.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://movie-database-alternative.p.rapidapi.com/?s=\(searchKeyword)&r=json&page=1")
        var request = URLRequest(url: url!)
        
        for h in headers {
            request.setValue(h.value, forHTTPHeaderField: h.key)
        }
         
        let (data, response) = try! await Foundation.URLSession.shared.data(for: request)
        
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            let r = (response as? HTTPURLResponse)
            print("Call failed with error code: \(r!.statusCode)")
        }
        
        let movies = try! JSONDecoder().decode(MovieSearch.self, from: data)
        
        result.removeAll()
        
//        print(movies)
        if (movies.Search != nil) {
                        
            result = movies.Search!
            
            return result
        }

        
        return []
        
    }
}
