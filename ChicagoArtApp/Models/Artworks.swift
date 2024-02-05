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
    
    init(data: [Artwork], pagination: Pagination) {
        self.data = data
        self.pagination = pagination
    }
    
    init(artworks: [String: Any]) {
        data = artworks["data"] as? [Artwork] ?? []
        pagination = artworks["pagination"] as? Pagination ?? Pagination(
            currentPage: 1,
            prevUrl: "fff",
            nextUrl: "fff"
        )
    }
        
    static func getArtworks(from value: Any) -> Artworks {
        guard let artworksDetails = value as? [String: Any] else {
            return Artworks(
                data: [],
                pagination: Pagination(
                    currentPage: 4,
                    prevUrl: "hhh",
                    nextUrl: "hhh"
                )
            ) 
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
    
    init(id: Int, title: String, imageId: String?, description: String?, dateDisplay: String) {
        self.id = id
        self.title = title
        self.imageId = imageId
        self.description = description
        self.dateDisplay = dateDisplay
    }
    
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
    
    init(currentPage: Int, prevUrl: String?, nextUrl: String?) {
        self.currentPage = currentPage
        self.prevUrl = prevUrl
        self.nextUrl = nextUrl
    }
    
    init(pagination: [String: Any]) {
        currentPage = pagination["current_page"] as? Int ?? 0
        prevUrl = pagination["prev_url"] as? String ?? ""
        nextUrl = pagination["next_url"] as? String ?? ""
    }
}
