//
//  NetworkManager.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 5.07.2023.
//

import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    static let sharedImage = NetworkManager()
    private let cache = NSCache<NSString,UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private init() {
        
    }
    @discardableResult
    func download(urlPath: String, completion: @escaping(Result<Data,Error>) -> ()) -> URLSessionDataTask? {
        
        guard let url = URL(string: urlPath) else { return nil }
        var request = URLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)

        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMDQ0OTM3NWZjYjU0NzE2YmE0NzEyZWZmNGMyZTY5ZiIsInN1YiI6IjYzNWZhNzk5ZWZkM2MyMDA5MThlMmQyNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hmgjsxF1NM69qqtwjFl_YfO9UEN6OYhUHd4hX_GoDuQ"
                         , forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return }
            
            guard let data = data else {
                completion(.failure(URLError(.badURL)))
                return }
            
            completion(.success(data))
        }
        dataTask.resume()
        return dataTask
    }
    
    func fetchImage(urlPath: String, completion: @escaping(UIImage?)-> ()) {
        if let image = cache.object(forKey: "image") {
            completion(image)
            return
        }
        guard let url = URL(string: urlPath) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _,  error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                completion(nil)
                return }
           
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return }
                self.cache.setObject(image, forKey: "image")
                completion(image)
            }
        }
        dataTask.resume()
    }
    
}


