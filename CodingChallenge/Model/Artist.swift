//
//  Artist.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation

typealias Artists = [Artist]

struct ArtistResults: Codable {
    let results: ArtistMatches
}

struct ArtistMatches: Codable {
    let artistmatches: ArtistInfo
}

struct ArtistInfo: Codable {
    let artist: Artists
}

class Artist: Codable {
    var name: String
    var image: [[String:String]]
    
    init(name: String, image: [[String:String]]) {
        self.name = name
        self.image = image
    }
}
