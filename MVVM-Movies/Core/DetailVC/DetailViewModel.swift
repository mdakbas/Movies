//
//  DetailViewModel.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 12.07.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var view: DetailVCProtocol? {get set}
    
    func viewDidLoad()
}

final class DetailViewModel {
    weak var view: DetailVCProtocol?
    
    
}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.configurePosterImageView()
        view?.downloadPosterImageView()
        view?.configureDateLabel()
        view?.configureTitleLabel()
        view?.configureOverviewLabel()
    }
}

