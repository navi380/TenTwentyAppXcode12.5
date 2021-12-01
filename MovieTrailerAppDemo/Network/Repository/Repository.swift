//
//  Repository.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

protocol Repository{
    func MoviesList(completion: @escaping ((Result<MovieListResponse>) -> ()))
    func MoviesListWithPagination(page: Int,completion: @escaping ((Result<MovieListResponse>) -> ()))
    func MoviesDetail(id: Int, completion: @escaping ((Result<MovieDetailBase>) -> ()))
    func MoviesVideo(movieId: Int, completion: @escaping ((Result<MovieVideoModel>) -> ())) 
}
