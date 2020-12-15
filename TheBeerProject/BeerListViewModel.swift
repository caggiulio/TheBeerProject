//
//  BeerListViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import HTTPiOSCLient

protocol BeerListViewModelDelegate: AnyObject {
    func passBeers(beers: [Beer])
}

class BeerListViewModel: NSObject {
    
    override init() {}
    weak var delegate: BeerListViewModelDelegate?
    
    func fetchBeers(page: Int, beerName: String = "", category: String = "") {
        API().getBeers(page: page, beerName: beerName, category: category) { (response) in
            if let json = response?.json {
                let beers = json.arrayValue.map { (singleJs) -> Beer in
                    return Beer(singleJs)
                }
                self.delegate?.passBeers(beers: beers)
            }
        }
    }
}
