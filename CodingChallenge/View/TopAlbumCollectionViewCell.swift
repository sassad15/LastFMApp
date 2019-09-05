//
//  TopAlbumCollectionViewCell.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class TopAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    
    static let identifier = "TopAlbum"
    
    func configure(top: TopAlbums) {
        mainLabel.text = top.name
        
        for image in top.image where image.values.contains(where: {$0.contains("large")}) {
            
            if let url = URL(string: image.values.first!) {
                
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
    
    
}
