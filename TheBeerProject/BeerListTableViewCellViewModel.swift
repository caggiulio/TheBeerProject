//
//  BeerListTableViewCellViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class BeerListTableViewCellViewModel: NSObject {
    
    weak var cellController: BeerTableViewCell? {
        didSet {
            updateUI()
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
    
    func updateUI() {
        cellController?.beerImage.sd_setImage(with: URL(string: beer?.imageUrl ?? ""))
        cellController?.beerTitle.text = beer?.name
        cellController?.beerSubtitle.text = beer?.tagline
        cellController?.beerDescr.text = beer?.description
    }
    
}
