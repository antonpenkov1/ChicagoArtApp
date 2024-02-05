//
//  Links.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import Foundation

enum Link {
    case artworks
    case startImage
    case endImage
    
    var url: URL {
        switch self {
        case .artworks:
            return URL(string: "https://api.artic.edu/api/v1/artworks?page=1&limit=20")!
        case .startImage:
            return URL(string: "https://www.artic.edu/iiif/2/")!
        case .endImage:
            return URL(string: "/full/843,/0/default.jpg")!
        }
    }
}
