//
//  WatchDetailViewModel.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 30/11/2021.
//

import Foundation

class WatchDetailViewModel {
    
    // MARK: - PROPERTIES
    var errorMessage: Observable<String?> = Observable(nil)
    
    var responseData: Observable<MovieDetailBase> = Observable(nil)
    var responseVideoData: Observable<MovieVideoModel> = Observable(nil)
   
    var myRepository : Repository?
    
    init(repository : Repository){
        myRepository  = repository
    }
    
    // MARK: - FUNCTIONS
    func getMovieDetail(id: Int){
        myRepository?.MoviesDetail(id: id, completion: { result in
            switch result{
            case .success(let data):
                self.responseData.value = data
            case .failure(let error):
                self.setError(error.localizedDescription)
            }
        })
    }
    
    func getMovieVideos(id: Int){
        myRepository?.MoviesVideo(movieId: id, completion: { result in
            switch result{
            case .success(let data):
                self.responseVideoData.value = data
            case .failure(let error):
                self.setError(error.localizedDescription)
            }
        })
    }
    private func setError(_ message: String) {
        self.errorMessage.value = message
    }
}
