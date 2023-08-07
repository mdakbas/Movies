//
//  MovieModel.swift
//  MVVM-Movies
//
//  Created by Mert Deniz Akbaş on 6.07.2023.
//

import Foundation

struct MovieModel: Decodable {
    let page: Int?
    let results: [MovieResults]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page , results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
}

struct MovieResults: Decodable {
    let id: Int?
    let posterPath: String?
    let releaseDate: String?
    let overview: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey  {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview, title
    }
    
    var _id: Int {
        id ?? Int.min
    }
    var _posterPath: String {
        posterPath ?? ""   
    }
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
    var _overview: String {
        overview ?? "N/A"
    }
    var _title: String {
        title ?? "N/A"
    }
    
}
