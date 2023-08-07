//
//  DetailVC.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 12.07.2023.
//

import UIKit
protocol DetailVCProtocol: AnyObject  {
    
    func configureVC()
    func configurePosterImageView()
    func downloadPosterImageView()
    func configureDateLabel()
    func configureTitleLabel()
    func configureOverviewLabel()
    
    
}
final class DetailVC: UIViewController {
    
    private let viewModel = DetailViewModel()
    private let movie: MovieResults
    
    private let padding: CGFloat = 15
    
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var overviewLabel: UILabel!
    
    var posterImageView: PosterImageView!
    
    init(movie: MovieResults) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        print(movie.title ?? "")
    }
}

extension DetailVC: DetailVCProtocol {

    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        view.addSubview(posterImageView)
        
        let posterWidth = CGFloat.deviceWitdh * 0.5
        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            posterImageView.heightAnchor.constraint(equalToConstant: posterWidth * 1.5),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth )
        ])
        
        posterImageView.backgroundColor = .systemRed
    }
    func downloadPosterImageView() {
        posterImageView.imageDownload(movie: movie)
    }
    
    func configureDateLabel(){
        let dateLabel = UILabel(frame: .zero)
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints()
        dateLabel.setLabel(text: movie._releaseDate, font: .systemFont(ofSize: 20), numberOfLines: 0)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5 * padding),
            dateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 1.5 * padding),
        ])
    }
    
    func configureTitleLabel() {
        let titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints()
        titleLabel.setLabel(text: movie._title, font: .systemFont(ofSize: 25), numberOfLines: 0)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureOverviewLabel() {
        let overViewLabel = UILabel(frame: .zero)
        
        view.addSubview(overViewLabel)
        
        overViewLabel.translatesAutoresizingMaskIntoConstraints()
        overViewLabel.setLabel(text: movie._overview, font: .systemFont(ofSize: 15), numberOfLines: 0)

        NSLayoutConstraint.activate([
            overViewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 2 * padding),
            overViewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


