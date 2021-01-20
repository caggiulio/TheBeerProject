//
//  BeerDetailPresenter.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 19/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

protocol BeerDetailPresenterView: NSObject {
    func updateUI(beer: Beer?)
}

class BeerDetailPresenter: NSObject {
    
    weak var view: BeerDetailPresenterView? {
        didSet {
            view?.updateUI(beer: beer)
        }
    }
    
    var beer: Beer?
    
    init(beer: Beer) {
        super.init()
        setBeer(beer: beer)
    }
    
    func attachView(view: BeerDetailPresenterView) {
        self.view = view
    }
    
    func setBeer(beer: Beer) {
        self.beer = beer
    }
}
