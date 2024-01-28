//
//  Artwork.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 28.01.2024.
//

import Foundation

struct Artwork: Decodable {
    let label: String
    let description: [Description]
    let metadata: [Metadata]
    let sequences: [Sequences]
}

struct Description: Decodable {
    let value: String
    let language: String
}

struct Metadata: Decodable {
    let label: String
    let value: String
}

struct Sequences: Decodable {
    let canvases: [Canvases]
}

struct Canvases: Decodable {
    let label: String
    let images: [Images]
}

struct Images: Decodable {
    let resource: Resource
}

struct Resource: Decodable {
    let id: String?
}
