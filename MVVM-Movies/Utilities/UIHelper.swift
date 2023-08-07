//
//  UIHelper.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 7.07.2023.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let itemWitdh = CGFloat.deviceWitdh
        layout.itemSize = CGSize(width: itemWitdh, height: itemWitdh * 1.5)
        layout.minimumLineSpacing = 35
        return layout
    }
}
