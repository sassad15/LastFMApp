//
//  TopAlbumViewController.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

class TopAlbumViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let topViewModel = TopViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addObserver()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch? = touches.first
        
        if touch?.view == self.collectionView.backgroundView || touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
   
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: Notification.Name.top5, object: nil)
    }
    
    
    @objc func updateView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

 

}



extension TopAlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topViewModel.topAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopAlbumCollectionViewCell.identifier, for: indexPath) as! TopAlbumCollectionViewCell
        
        let top = topViewModel.topAlbums[indexPath.row]
        
        cell.configure(top: top)
        
        
        return cell
    }
}


extension TopAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 245, height: 321)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}



extension TopAlbumViewController {
    
    static func instance(artist: String) -> TopAlbumViewController {
        
        let storyboard = UIStoryboard.init(name: "Second", bundle: nil)
        
        let topVC = storyboard.instantiateViewController(withIdentifier: "TopAlbumViewController") as! TopAlbumViewController
        
        topVC.topViewModel.getTop(for: artist)
        
        return topVC
    }
}
