//
//  MovieAPI.swift
//  Popcorn
//
//  Created by Ettore Toma on 18/05/2023.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation
import SwiftUI

let headers = [
    "Authorization": "Bearer " + ProcessInfo.processInfo.environment["API_TOKEN"]!,
    "Accept": "application/json"
]

struct Movie: Identifiable, Codable {
    var id: Int
    var title: String
    var release_date: String
    var poster_path: String?
    var vote_average: Float?
    var overview: String?
}

struct MovieSearch: Codable {
    var total_results: Int
    var results: [Movie]?
}

struct WatchlistObj: Codable, Identifiable {
    @DocumentID var id: String?
    
    var movieID: Int
    var userRating: Int
    var watched: Bool
}

struct WatchlistData: Codable, Identifiable {
    @DocumentID var id: String?

    var watchlist: [WatchlistObj]
}


class API {
    func FetchMovieFromKeyword(keyword: String) async -> [Movie] {
        
        let searchKeyword = keyword.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(searchKeyword)&language=en-US&page=1")
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

        if (movies.results != nil) {
            return movies.results!

        }
        return []
        
    }
    
    func FetchMovieFromID(id: Int) async -> Movie {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?language=en-US")
        var request = URLRequest(url: url!)
        
        for h in headers {
            request.setValue(h.value, forHTTPHeaderField: h.key)
        }
         
        let (data, response) = try! await Foundation.URLSession.shared.data(for: request)
        
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            let r = (response as? HTTPURLResponse)
            print("Call failed with error code: \(r!.statusCode)")
        }
        
        let movie = try! JSONDecoder().decode(Movie.self, from: data)
            
        return movie
    }
    
    func GetWatchlist() async -> [Int] {
        
        var moviesList: [Int] = []
        let db = Firestore.firestore()

        let docs = db.collection("users").document("ettore-1234")

        do {
            let doc = try await docs.getDocument()
            let data = try doc.data(as: WatchlistData.self)
            
            let _ = data.watchlist.map {movie in
                moviesList.append(movie.movieID)
            }
        }
        catch {
            print("document not found or cannot be parsed")
        }
        return moviesList.isEmpty ? [] : moviesList
    }
}




