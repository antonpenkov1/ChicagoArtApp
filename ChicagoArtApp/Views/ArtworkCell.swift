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
        
        let url = "\(Link.startImage.url)\(artwork.imageId ?? "")\(Link.endImage.url)"
        networkManager.fetchData(from: url) { [unowned self] result in
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
