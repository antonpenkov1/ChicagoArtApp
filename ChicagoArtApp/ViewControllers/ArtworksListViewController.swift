//
//  ViewController.swift
//  ChicagoArtApp
//
//  Created by Антон Пеньков on 28.01.2024.
//

import UIKit

final class ArtworksListViewController: UITableViewController {
    
    // MARK: - IBOutlets & Private Properties
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var prevButtonItem: UIBarButtonItem!
    @IBOutlet var nextButtonItem: UIBarButtonItem!
    
    private var artworks: [Artwork] = []
    private var pages: Pagination?
    private let networkManager = NetworkManager.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchArtworks(from: Link.artworks.url)
        setupPageButtons()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let artworkVC = segue.destination as? ArtworkViewController
        artworkVC?.artwork = artworks[indexPath.row]
    }
    
    // MARK: - IBActions
    @IBAction func reloadButtonAction(_ sender: Any) {
        activityIndicator.startAnimating()
        loadingLabel.text = "Loading artworks ..."
        fetchArtworks(from: Link.artworks.url)
    }
    
    @IBAction func previousButtonAction(_ sender: UIBarButtonItem) {
        activityIndicator.startAnimating()
        loadingLabel.text = "Loading artworks ..."
        
        fetchArtworks(from: (pages?.prevUrl)!)
    }
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        activityIndicator.startAnimating()
        loadingLabel.text = "Loading artworks ..."
        tableView.numberOfRows(inSection: 0)
        fetchArtworks(from: (pages?.nextUrl)!)
    }
    
    // MARK: - Private methods
    private func setupPageButtons() {
        prevButtonItem.tintColor = .systemBlue
        prevButtonItem.isEnabled = true
        
        nextButtonItem.tintColor = .systemBlue
        nextButtonItem.isEnabled = true
        
        if pages?.currentPage == 1 {
            prevButtonItem.tintColor = .gray
            prevButtonItem.isEnabled = false
        } else if pages?.nextUrl == nil {
            nextButtonItem.tintColor = .gray
            nextButtonItem.isEnabled = false
        }
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
    private func fetchArtworks(from url: URL) {
        networkManager.fetch(from: url) { [unowned self] result in
            switch result {
            case .success(let artworksData):
                artworks = artworksData.data
                pages = artworksData.pagination
                setupPageButtons()
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
