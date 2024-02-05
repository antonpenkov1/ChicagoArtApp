//
//  ArtworkCell.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import UIKit

final class ArtworkCell: UITableViewCell {
    
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var artworkTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with artwork: Artwork) {
        artworkTitleLabel.text = artwork.title
        dateLabel.text = artwork.dateDisplay
        
        let url = URL(string: "https://www.artic.edu/iiif/2/\(artwork.imageId)/full/843,/0/default.jpg")!
        networkManager.fetchImage(from: url) { [unowned self] result in
            switch result {
            case .success(let imageData):
                artworkImageView.image = UIImage(data: imageData)
                artworkImageView.contentMode = .scaleAspectFill
            case .failure(let error):
                print(error)
            }
        }
    }
}
