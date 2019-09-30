//
//  BeerListViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import PromiseKit

protocol BeerListViewModelDelegate: AnyObject {
    func passBeers(beers: [Beer])
}

class BeerListViewModel: NSObject {
    
    override init() {}
    weak var delegate: BeerListViewModelDelegate?
    
    func fetchBeers(page: Int, beerName: String = "", category: String = "") {
        firstly {
            API().getBeers(page: page, beerName: beerName, category: category)
        }.map { (json) -> [Beer] in
            let beers = json.arrayValue.map { (singleJs) -> Beer in
                return Beer(singleJs)
            }
            return beers
        }.done { (beers) in
            self.delegate?.passBeers(beers: beers)
        }.catch { (error) in
                print(error)
        }
    }
}
