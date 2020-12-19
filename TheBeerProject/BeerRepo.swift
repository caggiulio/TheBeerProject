//
//  BeerRepo.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 18/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

protocol BeerRepoDelegate: AnyObject {
    func notifyObservers(beers: [Beer])
}

class BeerRepo: NSObject {
    
    static var observers: [BeerRepoDelegate] = [BeerRepoDelegate]() {
        didSet {
            if observers.count == 1 && beers.count == 0 {
                setup()
            } else {
                if beers.count > 0 {
                    notifyObservers()
                }
            }
        }
    }
    
    static private var beers: [Beer]  = [Beer]() {
        didSet {
            self.notifyObservers()
        }
    }
    
    private static func setup() {
        BeerRepo.fetchBeers(page: 1)
    }
    
    
    static func fetchBeers(page: Int, beerName: String = "", category: String = "") {
        if (category != "" || beerName != "") && page == 1 {
            self.beers.removeAll()
        }
        API().getBeers(page: page, beerName: beerName, category: category) { (response) in
            if let json = response?.json {
                let beers = json.arrayValue.map { (singleJs) -> Beer in
                    return Beer(singleJs)
                }
                self.beers += beers
            }
        }
    }
    
    private static func notifyObservers() {
        for obs in observers {
            obs.notifyObservers(beers: beers)
        }
    }
    
    static func getBeers() -> [Beer] {
        return self.beers
    }
    
    static func editBeer(beer: Beer, index: Int) {
        self.beers[index] = beer
    }
    
    static func deleteBeer(index: Int) {
        self.beers.remove(at: index)
    }
    
    static func addBeerRepoObserver(obs: BeerRepoDelegate) {
        self.observers.append(obs)
    }
    
    static func removeBeerRepoObserver(obs: BeerRepoDelegate) {
        var i: Int = 0
        for o in observers {
            if obs === o {
                observers.remove(at: i)
                break
            } else {
                i += 1
            }
        }
    }
}
