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
        artworkDescriptionLabel.text = artwork.description?.replacingOccurrences(of: "<p>", with: " ")
        fetchImage()
    }
}

// MARK: - Networking
extension ArtworkViewController {
    private func fetchImage() {
        let url = "\(Link.startImage.url)\(artwork.imageId ?? "")\(Link.endImage.url)"
        networkManager.fetchData(from: url) { [unowned self] result in
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
