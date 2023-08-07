//
//  MovieService.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 6.07.2023.
//

import Foundation


class MovieService {
 
    func downloadMovies(page: Int,completion: @escaping([MovieResults]?) -> ()) {

        let urlPath = ApiUrls.movies(page: page)
 
    
        NetworkManager.shared.download(urlPath: urlPath) { [weak self] result in
            
            guard let self = self else {return}
            switch result {
                
            case .success(let data):
                completion(self.handleWithData(data))
                
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func downloadDetail(id: Int , completion: @escaping(MovieResults?) -> ()) {
        let urlPath = ApiUrls.detailURL(id: id)
   
    
        NetworkManager.shared.download(urlPath: urlPath) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
                 break
            case .failure(let error):
                self.handleWithError(error)
                break
            }
        }
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    private func handleWithData(_ data: Data) -> [MovieResults]?{
        do {
            let moviesModel = try JSONDecoder().decode(MovieModel.self, from: data)
            return moviesModel.results
        } catch {
            print(error)
            return nil
        }
        
    }
    private func handleWithData(_ data: Data) -> MovieResults?{
        do {
            let movieDetail = try JSONDecoder().decode(MovieResults.self, from: data)
            return movieDetail
        }catch {
            print(error)
            return nil
        }
        
    }
    
}
