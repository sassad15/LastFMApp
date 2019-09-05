//
//  TopAlbumViewModel.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation


class TopViewModel {
    
    var topAlbums = [TopAlbums]()
    
    func getTop(for artist: String) {
        
        ContentService.shared.getTopAlbums(for: artist) { [unowned self] albums in
            
            self.topAlbums = albums
            
            NotificationCenter.default.post(name: Notification.Name.top5, object: nil)
            
            print("Received top albums")
        }
        
    }
    
    
}
