//
//  BeerDetailAssembler.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 28/01/21.
//  Copyright © 2021 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class BeerDetailAssembler: BeerDetailAssmblerInjector {}

protocol BeerDetailAssmblerInjector {
    func resolve(beer: Beer, beerRepo: BeerRepo) -> BeerDetailViewController
    
    func resolve(beer: Beer, beerRepo: BeerRepo) -> BeerDetailPresenter
    
    func resolve(beerRepo: BeerRepo) -> BeerRepo
}

extension BeerDetailAssembler {
    func resolve(beer: Beer, beerRepo: BeerRepo) -> BeerDetailViewController {
        return BeerDetailViewController(presenter: resolve(beer: beer, beerRepo: beerRepo))
    }
    
    func resolve(beer: Beer, beerRepo: BeerRepo) -> BeerDetailPresenter {
        return BeerDetailPresenter(beer: beer, beerRepo: resolve(beerRepo: beerRepo))
    }
    
    func resolve(beerRepo: BeerRepo) -> BeerRepo {
        return beerRepo
    }
}
