//
//  LastAPI.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation

struct LastAPI {
    
   
    static let base = "http://ws.audioscrobbler.com/2.0/"
    
    
    
    static let artist = "?method=artist.search&artist="
    static let album = "?method=album.search&album="
    static let track = "?method=track.search&track="
    static let topAlbum = "?method=artist.gettopalbums&artist="
    
    
    static let key = "&api_key=43070dda2f585e51b62ead8380678e67&format=json&limit="
    
    
    
    static func getArtistURL(search: String, get amount: Int) -> String {
        return base + artist + search + key + "\(amount)"
    }
    
    static func getAlbumURL(search: String, get amount: Int) -> String {
        return base + album + search + key + "\(amount)"
    }
    
    static func getTrackURL(search: String, get amount: Int) -> String {
        return base + track + search + key + "\(amount)"
    }
    
    static func getTopAlbums(search: String) -> String {
        return base + topAlbum + search + key + "\(5)"
    }
    
}
