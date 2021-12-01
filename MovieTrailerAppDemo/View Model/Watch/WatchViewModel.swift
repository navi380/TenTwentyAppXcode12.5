//
//  WatchViewModel.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation


class WatchViewModel {
    
    // MARK: - PROPERTIES
    var errorMessage: Observable<String?> = Observable(nil)
    
    var responseData: Observable<MovieListResponse> = Observable(nil)
    
   
    var myRepository : Repository?
    
    init(repository : Repository){
        myRepository  = repository
    }
    
    // MARK: - FUNCTIONS
    func getPopularMovies(){
        myRepository?.MoviesList(completion: { result in
            switch result{
            case .success(let data):
                self.responseData.value = data
            case .failure(let error):
                self.setError(error.localizedDescription)
            }
        })
    }
    
    
    func getPopularPoginationMovies(page: Int){
        myRepository?.MoviesListWithPagination(page: page, completion: { result in
            switch result{
            case .success(let data):
                self.responseData.value = data
            case .failure(let error):
                self.setError(error.localizedDescription)
            }
        })
    }
    
    private func setError(_ message: String) {
        self.errorMessage.value = message
    }
}
