//
//  UILabel + Ext.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 3.08.2023.
//

import UIKit

extension UILabel{
    func setLabel(text: String , font: UIFont, numberOfLines: Int){
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
