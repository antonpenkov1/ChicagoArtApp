//
//  Artworks.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import Foundation

struct Artworks {
    let data: [Artwork]
    let pagination: Pagination
    
    init(artworks: [String: Any]) {
        let artworkDetails = artworks["data"] as? [[String: Any]] ?? []
        data = artworkDetails.map {Artwork(artwork: $0)}
        
        let paginationDetails = artworks["pagination"] as? [String: Any] ?? [:]
        pagination = Pagination(pagination: paginationDetails)
    }
        
    static func getArtworks(from value: Any) -> Artworks {
        guard let artworksDetails = value as? [String: Any] else {
            return Artworks(artworks: [:])
        }
        return Artworks(artworks: artworksDetails)
    }
}

struct Artwork {
    let id: Int
    let title: String
    let imageId: String?
    let description: String?
    let dateDisplay: String
    
    init(artwork: [String: Any]) {
        id = artwork["id"] as? Int ?? 0
        title = artwork["title"] as? String ?? ""
        imageId = artwork["image_id"] as? String ?? ""
        description = artwork["description"] as? String ?? ""
        dateDisplay = artwork["date_display"] as? String ?? ""
    }
}

struct Pagination {
    let currentPage: Int
    let prevUrl: String?
    let nextUrl: String?
    
    init(pagination: [String: Any]) {
        currentPage = pagination["current_page"] as? Int ?? 0
        prevUrl = pagination["prev_url"] as? String ?? ""
        nextUrl = pagination["next_url"] as? String ?? ""
    }
}
