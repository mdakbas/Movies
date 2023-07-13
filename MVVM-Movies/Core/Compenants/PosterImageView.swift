//
//  PosterImageView.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 10.07.2023.
//

import UIKit

class PosterImageView: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageDownload(movie: MovieResults){
 
       let urlPath = ApiUrls.imageURL(posterPath: movie._posterPath)
        dataTask = NetworkManager.shared.download(urlPath: urlPath) { [weak self] results in
            guard let self = self else { return }

            switch results {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
    }

    func cancelDownloading(){
        dataTask?.cancel()
        dataTask = nil
    }
}

