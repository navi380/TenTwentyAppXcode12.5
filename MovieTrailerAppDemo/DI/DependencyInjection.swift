//
//  DependencyInjection.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

class ProvideViewModel{
    
    // MARK: - singleton
    static let provide = ProvideViewModel()
    private init() {}

    // MARK: - Watch VIEW MODEL RESPOSITORY INJECTION
    func watchViewModel() -> WatchViewModel{
        return WatchViewModel(repository: LiveDataRepository.shared)
    }
   
    func watchDetailViewModel() -> WatchDetailViewModel{
        return WatchDetailViewModel(repository: LiveDataRepository.shared)
    }
    
   
}
