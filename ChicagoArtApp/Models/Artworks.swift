//
//  Artworks.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import Foundation

struct Artworks: Decodable {
    let data: [Artwork]
    let pagination: Pagination
}

struct Artwork: Decodable {
    let id: Int
    let title: String
    let imageId: String
    let description: String?
    let dateDisplay: String
    let artworkTypeTitle: String
}

struct Pagination: Decodable {
    let currentPage: Int
    let prevUrl: String
    let nextUrl: String
}
