//
//  ViewController.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 28.01.2024.
//

import UIKit

enum Link {
    case rubensURL
    case bouguereauURL
    
    var url: URL {
        switch self {
        case .rubensURL:
            return URL(string: "https://api.artic.edu/api/v1/artworks/27310/manifest.json")!
        case .bouguereauURL:
            return URL(string: "https://api.artic.edu/api/v1/artworks/39560/manifest.json")!
        }
    }
}

final class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtwork()
    }
        
}

// MARK: - Networking
extension ViewController {
    private func fetchArtwork() {
        URLSession.shared.dataTask(with: Link.bouguereauURL.url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let artwork = try JSONDecoder().decode(Artwork.self, from: data)
                print(artwork)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}
