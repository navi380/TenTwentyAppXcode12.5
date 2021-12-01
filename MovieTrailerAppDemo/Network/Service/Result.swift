//
//  Result.swift
//  FinalProject
//
//  Created by Naveed Tahir on 09/11/2021.
//

import Foundation

// MARK: - SUCCESS WILL HAVE ANY MODEL
enum Result<T> {
    case success(T)
    case failure(Error)
}
