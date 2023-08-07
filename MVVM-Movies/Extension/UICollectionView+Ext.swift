//
//  UICollectionView+Ext.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 11.07.2023.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
    }
}
