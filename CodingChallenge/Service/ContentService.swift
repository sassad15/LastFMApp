//
//  ContentService.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import Foundation

typealias ArtistHandler = (Artists) -> Void
typealias AlbumHandler = (Albums) -> Void
typealias TrackHandler = (Tracks) -> Void

typealias ContentHandler = ([Content]) -> Void
typealias TopAlbumHandler = ([TopAlbums]) -> Void

final class ContentService {
    
   
    static let shared = ContentService()
    
    private init() {}
    
    
    func getContent(search: String, artist: Int, albums: Int, tracks: Int, completion: @escaping ContentHandler) {
        
        var myContent = [Content]()
        let dispatchGroup = DispatchGroup()
        
        
        dispatchGroup.enter()
        
        getAlbums(search: search, limit: albums) { albums in
            
            for album in albums {
                
                myContent.append(.album(album))
            }
            dispatchGroup.leave()
        }
        
        
        
    
        dispatchGroup.enter()
        getArtists(search: search, limit: artist) { artists in
            
            for artist in artists {
                myContent.append(.artist(artist))
                
            }
            dispatchGroup.leave()
        }
        
        
       
        
        dispatchGroup.enter()
        getTracks(search: search, limit: tracks) { tracks in
            for track in tracks {
                myContent.append(.track(track))
            }
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .global()) {
            completion(myContent)
        }
        
    }
    
    
    
    
    func getArtists(search: String, limit: Int, completion: @escaping ArtistHandler) {
        
        if let url = URL(string: LastAPI.getArtistURL(search: search, get: limit)) {
            
            
            var artistArray = Artists()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        let responseData = try JSONDecoder().decode(ArtistResults.self, from: data)
                        
                        var name: String!
                        
                        
                        for artist in responseData.results.artistmatches.artist {
                            
                            name = artist.name
                            
                           
                            for dictionary in artist.image {
                                
                                for value in dictionary.values {
                                    
                                    if value == "large" {
                                        
                                        let artist = Artist(name: name, image: [dictionary])
                                        artistArray.append(artist)
                                        
                                    }
                                }
                            }
                        }
                        
                        
                        completion(artistArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
                
                }.resume()
        }
        
    }
    
    
    
   
    
    func getAlbums(search: String, limit: Int, completion: @escaping AlbumHandler) {
        
        if let url = URL(string: LastAPI.getAlbumURL(search: search, get: limit)) {
            
            
            var albumArray = Albums()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(AlbumResults.self, from: data)
                        
                        var name: String!
                        var artist: String!
                        
                        
                        for album in responseData.results.albummatches.album {
                            
                            name = album.name
                            artist = album.artist
                            
                            
                            for dictionary in album.image {
                                
                                for value in dictionary.values {
                                    
                                    if value == "large" {
                                        
                                        let album = Album(name: name, artist: artist, image: [dictionary])
                                        albumArray.append(album)
                                    }
                                }
                            }
                        }
                        
                        
                        completion(albumArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
                
                }.resume()
        }
        
    }
    
    
    
    
    
    
    
    func getTracks(search: String, limit: Int, completion: @escaping TrackHandler) {
        
        
        if let url = URL(string: LastAPI.getTrackURL(search: search, get: limit)) {
            
            
            var trackArray = Tracks()
            
            URLSession.shared.dataTask(with: url) { (d, _, e) in
                
                if let error = e {
                    print("Error: \(error)")
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(TrackResults.self, from: data)
                        
                        var name: String!
                        var artist: String!
                        
                        
                        for track in responseData.results.trackmatches.track {
                            
                            name = track.name
                            artist = track.artist
                            
                            
                            for dictionary in track.image {
                                
                                for value in dictionary.values {
                                    
                                    if value == "large" {
                                        
                                        let track = Track(name: name, artist: artist, image: [dictionary])
                                        trackArray.append(track)
                                    }
                                }
                            }
                        }
                        
                        
                        completion(trackArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                        
                    }
                }
                
                }.resume()
        }
    }
    
    
   
    
    func getTopAlbums(for artist: String, completion: @escaping TopAlbumHandler) {
        
        if let url = URL(string: LastAPI.getTopAlbums(search: artist) ) {
            
            var topAlbumArray = [TopAlbums]()
            
            URLSession.shared.dataTask(with: url) { (d, response, e) in
                
                if let error = e {
                    print(error)
                    completion([])
                }
                
                if let data = d {
                    
                    do {
                        
                        let responseData = try JSONDecoder().decode(TopAlbumsResult.self, from: data)
                        
                        
                        for top in responseData.topalbums.album {
                            
                            var name: String!
                            var imageDict: [[String:String]]!
                            
                            for dictionary in top.image {
                                for value in dictionary.values {
                                    if value == "large" {
                                        //set values for object
                                        imageDict = [dictionary]
                                        name = top.name
                                    }
                                }
                            }
                            
                            topAlbumArray.append(TopAlbums(name: name, image: imageDict))
                        }
                        
                        completion(topAlbumArray)
                        
                    } catch {
                        
                        print("Error: \(error)")
                        
                    }
                }
            }.resume()
        
        }
        
    }
    
    
    
    
} 
