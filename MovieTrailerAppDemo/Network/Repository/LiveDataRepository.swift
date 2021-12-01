//
//  LiveDataRepository.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

class LiveDataRepository: Repository {
    
    // MARK: - SINGLETON
    public static var shared = LiveDataRepository()
    private init(){}
    
    private let networkService = NetworkService()
    
    
    func MoviesList(completion: @escaping ((Result<MovieListResponse>) -> ())) {
        networkService.sendRequest(url: .popularMoviesUrl, headerValue: Constants.shared.requestMoviesListHeaders, for: MovieListResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func MoviesListWithPagination(page: Int, completion: @escaping ((Result<MovieListResponse>) -> ())) {
        var url: URL = .popularMoviesPaginationUrl
        url.appendQueryItem(name: "page", value: "\(page)")
        networkService.sendRequest(url: url, headerValue: Constants.shared.requestMoviesListHeaders, for: MovieListResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func MoviesDetail(id: Int, completion: @escaping ((Result<MovieDetailBase>) -> ())) {
        var url: URL = .movieDetailUrl
        url.appendPathComponent("\(id)")
        url.appendQueryItem(name: "api_key", value: "68fd21a4c9e73b906efe2f7e1b5de9da")
        networkService.sendRequest(url: url, headerValue: Constants.shared.requestMoviesDetailHeaders, for: MovieDetailBase.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func MoviesVideo(movieId: Int, completion: @escaping ((Result<MovieVideoModel>) -> ())) {
        var url: URL = .movieDetailUrl
        url.appendPathComponent("\(movieId)/videos")
        url.appendQueryItem(name: "api_key", value: "68fd21a4c9e73b906efe2f7e1b5de9da")
        networkService.sendRequest(url: url, headerValue: Constants.shared.requestMoviesVideosHeaders, for: MovieVideoModel.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


            
