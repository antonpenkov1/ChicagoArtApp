//
//  ArtworkViewController.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 01.02.2024.
//

import UIKit

final class ArtworkViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var artworkTitleLabel: UILabel!
    @IBOutlet var artworkDateLabel: UILabel!
    @IBOutlet var artworkDescriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    var artwork: Artwork!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        artworkTitleLabel.text = artwork.title
        artworkDateLabel.text = artwork.dateDisplay
        artworkDescriptionLabel.text = artwork.description
        fetchImage()
    }
}

// MARK: - Networking
extension ArtworkViewController {
    private func fetchImage() {
        let url = URL(string: "https://www.artic.edu/iiif/2/\(artwork.imageId)/full/843,/0/default.jpg")!
        networkManager.fetchImage(from: url) { [unowned self] result in
            switch result {
            case .success(let imageData):
                artworkImageView.image = UIImage(data: imageData)
                artworkImageView.contentMode = .scaleAspectFit
                activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
