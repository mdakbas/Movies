//
//  MovieCell.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 7.07.2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let movieCellReuseID = "Movie Cell"
    
     var posterImageView: PosterImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configurePosterImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // posterImageView = nil
        posterImageView.cancelDownloading()
    }
    private func configureCell() {
        backgroundColor = .black
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    func setCell(movie: MovieResults){
        posterImageView.imageDownload(movie: movie)
    }
    
    private func configurePosterImageView(){
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        posterImageView.pinToEdges(view: self)
    }
    
    
}
