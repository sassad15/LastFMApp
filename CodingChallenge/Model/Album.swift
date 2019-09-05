//
//  Album.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation

typealias Albums = [Album]

struct AlbumResults: Codable {
    let results: AlbumMatches
}

struct AlbumMatches: Codable {
    let albummatches: AlbumInfo
}


struct AlbumInfo: Codable {
    let album: Albums
}


class Album: Codable {
    
    var name: String
    var artist: String
    var image: [[String:String]]
    
    init(name: String, artist: String, image: [[String:String]]) {
        self.name = name
        self.artist = artist
        self.image = image
    }
}
