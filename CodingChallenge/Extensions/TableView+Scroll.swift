//
//  TableView+Scroll.swift
//  CodingChallenge
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scroll(to: scrollsTo, animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections - 1)
            
            switch to {
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfRows - 1)
                    self.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
        
    }
    
    enum scrollsTo {
        case top
        case bottom
    }
}
