//
//  HomeVC.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 5.07.2023.
//

import UIKit

protocol HomeVCProtocol: AnyObject {
    func configureVC()
    func configurecollectionView()
    func collectionViewReload()
    func navigateToDetailVC(movie: MovieResults)
}

final class HomeVC: UIViewController {
    private let homeViewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    
    private let cache = NSCache<NSNumber, UIImage>()
   private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.view = self
        homeViewModel.viewDidLoad()
    }
}

extension HomeVC: HomeVCProtocol {

    func configureVC() {
        view.backgroundColor = .systemBlue
        self.title = "Popular Movies"
    }
    
    func configurecollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.movieCellReuseID )
        
        collectionView.pinToEdges(view: view)
        collectionView.backgroundColor = .systemBackground
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.moviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.movieCellReuseID, for: indexPath) as! MovieCell
        cell.setCell(movie: homeViewModel.getMovieModel(index: indexPath.row))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pathid = homeViewModel.getMovieModel(index: indexPath.row)._id
       homeViewModel.getDetail(id: pathid)
    }

    func collectionViewReload() {
        collectionView.reloadOnMainThread()
    }
    func navigateToDetailVC(movie: MovieResults) {
        DispatchQueue.main.async {
            let detailVC = DetailVC(movie: movie)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY >= (contentHeight -  (2 * height)){
            homeViewModel.getMovies(page: homeViewModel.page)
            homeViewModel.page += 1
            
        }
    }
}

