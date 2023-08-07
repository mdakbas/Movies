//
//  ApiUrls.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 6.07.2023.
//

import Foundation

enum ApiUrls {
    static func movies(page: Int) -> String{
        return "https://api.themoviedb.org/3/movie/popular?language=en-US&\(page)"
    }
    
    static func imageURL(posterPath: String) -> String{
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    static func detailURL(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)?language=en-US"
    }
}
