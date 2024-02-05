//
//  ViewController.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 28.01.2024.
//

import UIKit

final class ArtworksListViewController: UITableViewController {
    
    // MARK: - Private Properties & View Lifecycle
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var artworks: [Artwork] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchArtworks()
    }
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        activityIndicator.startAnimating()
        loadingLabel.text = "Loading artworks ..."
        fetchArtworks()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let artworkVC = segue.destination as? ArtworkViewController
        artworkVC?.artwork = artworks[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension ArtworksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artworks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artworkCell", for: indexPath)
        guard let cell = cell as? ArtworkCell else { return UITableViewCell() }
        
        let artwork = artworks[indexPath.row]
        cell.configure(with: artwork)
        
        return cell
    }
}

// MARK: - Networking
extension ArtworksListViewController {
    private func fetchArtworks() {
        networkManager.fetch(Artworks.self, from: Link.artworks.url) { [unowned self] result in
            switch result {
            case .success(let artworksData):
                artworks = artworksData.data
                activityIndicator.stopAnimating()
                loadingLabel.isHidden = true
                tableView.reloadData()
                print(artworksData)
            case .failure(let error):
                activityIndicator.stopAnimating()
                loadingLabel.text = "Couldn't load artworks"
                print(error)
            }
        }
    }
}
