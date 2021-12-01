//
//  Constants.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

class Constants{
    // MARK: - SINGLETON
    static var shared = Constants()
    private init(){}
    

    // MARK: - REQUEST HEADER PROPERTIES
    var requestMoviesListHeaders : [String : String] {
           return [
            "Content-Type": "application/json",
            ]
    }
   
    var requestMoviesDetailHeaders : [String : String] {
           return [
            "Content-Type": "application/json",
            "append_to_response": "videos,credits"
        ]
    }
   
    var requestMoviesVideosHeaders : [String : String] {
           return [
            "Content-Type": "application/json",
        ]
    }
}
