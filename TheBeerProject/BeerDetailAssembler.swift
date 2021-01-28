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
    func resolve(beer: Beer) -> BeerDetailViewController
    
    func resolve(beer: Beer) -> BeerDetailPresenter
    
    func resolve() -> BeerRepo
    
    func resolve() -> API
}

extension BeerDetailAssembler {
    func resolve(beer: Beer) -> BeerDetailViewController {
        return BeerDetailViewController(presenter: resolve(beer: beer))
    }
    
    func resolve(beer: Beer) -> BeerDetailPresenter {
        return BeerDetailPresenter(beer: beer, beerRepo: resolve())
    }
    
    func resolve() -> BeerRepo {
        if let repo = RepoContainer.repoContainer.first, repo is BeerRepo {
            return repo as! BeerRepo
        }
        return BeerRepo(service: resolve())
    }
    
    func resolve() -> API {
        return API()
    }
}
