//
//  BeerDetailViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 19/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class BeerDetailViewModel: NSObject {
    
    weak var viewController: BeerDetailViewController? {
        didSet {
            if let _ = beerVM {
                updateUI()
            }
        }
    }
    
    var beerVM: Beer?
    
    init(beer: Beer) {
        super.init()
        setBeer(beer: beer)
    }
    
    func setBeer(beer: Beer) {
        self.beerVM = beer
    }
    
    func updateUI() {
        viewController?.beerImage.sd_setImage(with: URL(string: (beerVM?.imageUrl!)!))
        viewController?.beerTitle.text = beerVM?.name
        viewController?.beerSubtitle.text = beerVM?.tagline
        viewController?.beerDescr.text = beerVM?.description
    }
    
}
