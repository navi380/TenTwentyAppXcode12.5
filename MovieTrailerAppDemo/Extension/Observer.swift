//
//  Observer.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation

class Observable<T> {
    var value : T? {
        didSet{
            listner?(value)
        }
    }
    
    init(_ value: T?){
        self.value = value
    }
    
    private var listner: ((T?) -> Void)?
    
    func bind(_ listner: @escaping ((T?) -> Void) ) {
        listner(value)
        self.listner = listner
    }
}
