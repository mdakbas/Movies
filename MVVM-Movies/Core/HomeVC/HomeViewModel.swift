//
//  HomeViewModel.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 6.07.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var view:  HomeVCProtocol? { get set }
    
    func viewDidLoad()
    func getMovies(page: Int)
    func moviesCount() -> Int
    func getDetail(id: Int)
}

final class HomeViewModel {
    weak var view: HomeVCProtocol?
    private let service = MovieService()
    var moviesService: [MovieResults] = []
    var page: Int = 1
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.configurecollectionView()
        getMovies(page: page)
    }
    
    func getMovies(page: Int) {
        service.downloadMovies(page: page) { [weak self] returnedMovies in
            guard let self = self else {return}
            guard let returnedMovies = returnedMovies else {return}
            self.moviesService.append(contentsOf: returnedMovies)
            self.view?.collectionViewReload()
            
            //            Datalari kontrol edildi.
            //            print("ReturnCount = \(returnedMovies.count)")
            //            print("MovieCount = \(moviesService.count)")
            //            print("")
        }
    }
    
    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else { return }
            guard let returnedDetail = returnedDetail else { return }
            
            self.view?.navigateToDetailVC(movie: returnedDetail)
        }
    }
    
    func moviesCount() -> Int {
        return moviesService.count
    }
    
    func getMovieModel(index: Int) -> MovieResults {
        return moviesService[index]
    }
}


