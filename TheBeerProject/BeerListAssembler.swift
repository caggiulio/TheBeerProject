//
//  BeerListAssembler.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 28/01/21.
//  Copyright © 2021 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class BeerListAssembler: BeerListAssemblerInjector { }

protocol BeerListAssemblerInjector {
    func resolve() -> BeerListViewController
    
    func resolve() -> BeerListPresenter
    
    func resolve() -> BeerRepo
    
    func resolve() -> API
}

extension BeerListAssembler {
    func resolve() -> BeerListViewController {
        return BeerListViewController(presenter: resolve())
    }
    
    func resolve() -> BeerListPresenter {
        return BeerListPresenter(beerRepo: resolve())
    }
    
    func resolve() -> BeerRepo {
        return BeerRepo(service: resolve())
    }
    
    func resolve() -> API {
        return API()
    }
}
