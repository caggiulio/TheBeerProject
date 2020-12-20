//
//  BeerListTableViewCellPresenterDelegate.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

protocol BeerListTableViewCellPresenterDelegate: NSObject {
    func updateUI(beer: Beer)
}

class BeerListTableViewCellPresenter: NSObject {
    
    weak var delegate: BeerListTableViewCellPresenterDelegate? {
        didSet {
            if let _ = beer {
                delegate?.updateUI(beer: beer!)
            }
        }
    }
    
    var beer: Beer?
    
    init(beer: Beer) {
        super.init()
        setBeer(beer: beer)
    }
    
    func setBeer(beer: Beer) {
        self.beer = beer
    }
    
}
