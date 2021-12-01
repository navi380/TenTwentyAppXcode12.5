//
//  URL+EXT.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

extension URL {
    static var popularMoviesUrl: URL {
        baseUrl("movie/popular?api_key=68fd21a4c9e73b906efe2f7e1b5de9da&page=10")
    }
    
    static var popularMoviesPaginationUrl: URL {
        baseUrl("movie/popular?api_key=68fd21a4c9e73b906efe2f7e1b5de9da")
    }
    
    static var movieDetailUrl : URL {
        baseUrl("movie")
    }
    
    static var movieVideosUrl: URL{
        baseUrl("movie")
    }
}


private extension URL {
    static func baseUrl(_ endpoint: String) -> URL {
        URL(string: "https://api.themoviedb.org/3/\(endpoint)")!
    }
}


extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}
