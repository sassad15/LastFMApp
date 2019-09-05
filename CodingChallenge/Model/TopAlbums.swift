//
//  TopAlbums.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation


struct TopAlbumsResult: Codable {
    var topalbums: AlbumsDetail
}

struct AlbumsDetail: Codable {
    var album: [TopAlbums]
}

class TopAlbums: Codable {
    
    var name: String
    var image: [[String:String]]
    
    init(name: String, image: [[String:String]]) {
        self.name = name
        self.image = image
    }
}
