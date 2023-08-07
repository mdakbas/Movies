//
//  UIView+Ext.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 7.07.2023.
//

import UIKit


extension UIView{
    func pinToEdges(view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func translatesAutoresizingMaskIntoConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
