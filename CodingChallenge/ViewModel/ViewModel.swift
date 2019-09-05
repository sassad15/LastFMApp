//
//  ViewModel.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateView()
}

class ViewModel {
    
    var content = [Content]()
    
    var albums = Albums()
    var artists = Artists()
    var tracks = Tracks()
    
    weak var delegate: ViewModelDelegate?
    
    
    var artistLimit = 10
    var albumLimit = 10
    var trackLimit = 10
    
    
    func updateLimits() {
        
        
        artistLimit += 10
        albumLimit += 10
        trackLimit += 10
        
    }
    
    func resetLimits() {
        
        artistLimit = 10
        albumLimit = 10
        trackLimit = 10
        
    }
    
    
    var isLoadingMore: Bool {
        if artistLimit + albumLimit + trackLimit < 50 {
            return true
        }
        
        return false
    }
    
    
    func getContent(with search: String) {
        
        ContentService.shared.getContent(search: search, artist: artistLimit, albums: albumLimit, tracks: trackLimit) { [unowned self] content in
            
            self.content = content
            self.updateData()
            self.delegate?.updateView()
            
            print("Received Content: \(self.content.count)")
        }
    }
    
    func updateData() {
        
        
        artists = []
        albums = []
        tracks = []
        
        
        for item in content {
            
            switch item {
                
            case .album(let album):
                
                albums.append(album)
                
            case .artist(let artist):
                
                artists.append(artist)
                
            case .track(let track):
                
                tracks.append(track)
                
            default:
                break
            }
        }
    }
}
