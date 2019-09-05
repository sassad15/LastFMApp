//
//  SearchTableViewCell.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    static let identifier = "CellID"
    
    override func prepareForReuse() {
        mainImage.image = nil
    }
    
    
    
    func configureArtist(artist: Artist) {
        title.text = artist.name
        subTitle.isHidden = true
        
        
        for image in artist.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            let imageData = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                self.mainImage.image = imageData
            }
        }
    }
    
    
    
    
    
    
    func configureAlbum(album: Album) {
        
        title.text = album.name
        subTitle.text = album.artist
        
        
        for image in album.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            let imageData = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                self.mainImage.image = imageData
            }
        }
    }
    
    
    
    func configureTrack(track: Track) {
        
        title.text = track.name
        subTitle.text = track.artist
        
        
        for image in track.image where image.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: image.values.first!)!
            //optional binding to receive data from url
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            let imageData = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                self.mainImage.image = imageData
            }
        }
    }
    
    

}
