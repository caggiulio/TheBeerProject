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
    
    func fetchBeers(page: Int, beerName: String = "") {
        firstly {
            API().getBeers(page: page, beerName: beerName)
            }.done { (json) in
                let beersJson = json.arrayValue
                var beers: [Beer] = [Beer]()
                for beerJson in beersJson {
                    let beer = Beer(beerJson)
                    beers.append(beer)
                }
                self.delegate?.passBeers(beers: beers)
            }.catch { (error) in
                print(error)
        }
    }
}
