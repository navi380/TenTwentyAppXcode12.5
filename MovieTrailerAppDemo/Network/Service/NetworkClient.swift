//
//  NetworkClient.swift
//  FinalProject
//
//  Created by Naveed Tahir on 09/11/2021.
//

import Foundation


protocol NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

extension URLSession: NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
            self.dataTask(with: request) { (data, response, error) in
                if error != nil || data == nil {
                        print("Client error!")
                        return
                    }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        print("Server error!")
                        return
                }
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            }.resume()
        
    }
}
