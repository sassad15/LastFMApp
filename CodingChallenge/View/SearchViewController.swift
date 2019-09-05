//
//  ViewController.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchSettings()
        editTableView()
        
        viewModel.delegate = self
    }
    
    
    func searchSettings() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Last.FMApp..."
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func editTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = UIColor.white
    }

}


extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchBarIsEmpty() {
            self.viewModel.resetLimits()
        } else {
            
            let searchText = searchController.searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            viewModel.getContent(with: searchText)
            
        }
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return viewModel.artists.count
        case 1:
            return viewModel.albums.count
        default:
            return viewModel.tracks.count
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        switch indexPath.section {
        case 0:
            let artist = viewModel.artists[indexPath.row]
            cell.configureArtist(artist: artist)
        case 1:
            let album = viewModel.albums[indexPath.row]
            cell.configureAlbum(album: album)
        default:
            let track = viewModel.tracks[indexPath.row]
            cell.configureTrack(track: track)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return viewModel.artists.isEmpty ? "" : Constants.artists
        case 1:
            return viewModel.albums.isEmpty ? "" : Constants.albums
        case 2:
            return viewModel.tracks.isEmpty ? "" : Constants.tracks
        default:
            break
        }
        
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        
        if maximumOffset - currentOffset <= 10.0 && !viewModel.content.isEmpty && viewModel.isLoadingMore {
            
            viewModel.updateLimits()
            self.updateSearchResults(for: searchController)
            print("End of Scrolling Table View")
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        switch indexPath.section {
        case 0:
            //Artist
            detailVC.content = .artist(self.viewModel.artists[indexPath.row])
        case 1:
            //Album
            detailVC.content = .album(self.viewModel.albums[indexPath.row])
        case 2:
            //Track
            detailVC.content = .track(self.viewModel.tracks[indexPath.row])
        default:
            break
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}

extension SearchViewController: ViewModelDelegate {
    
    func updateView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scroll(to: .top, animated: true)
            print("reloaded table view")
        }
    }
}
