//
//  ArtworkCell.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import UIKit
import Kingfisher

final class ArtworkCell: UITableViewCell {
    
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var artworkTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with artwork: Artwork) {
        artworkTitleLabel.text = artwork.title
        dateLabel.text = artwork.dateDisplay
        
        let url = URL(string: "\(Link.startImage.url)\(artwork.imageId ?? "")\(Link.endImage.url)")
        let processor = DownsamplingImageProcessor(size: artworkImageView.bounds.size)
        artworkImageView.kf.indicatorType = .activity
        artworkImageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1))
            ]
        )
    }
}
