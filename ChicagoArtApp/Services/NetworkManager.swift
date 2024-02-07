//
//  NetworkManager.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchArtworks(from url: URL, completion: @escaping(Result<Artworks, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let artworks = Artworks.getArtworks(from: value)
                    completion(.success(artworks))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
