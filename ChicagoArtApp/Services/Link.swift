//
//  Links.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import Foundation

enum Link {
    case artworks
    
    var url: URL {
        switch self {
        case .artworks:
            return URL(string: "https://api.artic.edu/api/v1/artworks?page=3&limit=100")!
        }
    }
}
