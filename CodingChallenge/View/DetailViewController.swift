//
//  DetailViewController.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    var content = Content.empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentToObject()
        

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: CGPoint = (touches.first?.preciseLocation(in: self.view))!
        
        if self.mainImage.frame.contains(touch)  {
            
            guard let artist = mainLabel.text?.replacingOccurrences(of: " ", with: "") else { return }
            
            let topAlbums = TopAlbumViewController.instance(artist: artist)
            
            present(topAlbums, animated: true, completion: nil)
    
        }
    }
    
    
    func contentToObject() {
        
        switch content {
            
        case .artist(let artist):
            configure(artist: nil, name: artist.name, image: artist.image)
        case .album(let album):
            configure(artist: album.artist, name: album.name, image: album.image)
            subLabel.isHidden = false
        case .track(let track):
            configure(artist: track.artist, name: track.name, image: track.image)
            
        default:
            break
        }
    }
    
    
    func configure(artist: String?, name: String, image: [[String:String]]) {
        
        mainLabel.text = name
        
        if let artistName = artist {
            
            subLabel.text = artistName
            subLabel.isHidden = false
            
        }
        
        for dictionary in image where dictionary.values.contains(where: {$0.contains("large")}) {
            
            let url = URL(string: dictionary.values.first!)
            
            guard let data = try? Data(contentsOf: url!) else {
                return
            }
            
            let imageData = UIImage(data: data)
            
            mainImage.image = imageData
            
        }
    }
    



}
