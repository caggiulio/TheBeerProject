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
    
    var service: API?
    
    var observers: [BeerRepoDelegate] = [BeerRepoDelegate]() {
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
    
    private var beers: [Beer]  = [Beer]() {
        didSet {
            self.notifyObservers()
        }
    }
    
    private func setup() {
        self.fetchBeers(page: 1)
    }
    
    init(service: API) {
        super.init()
        setService(service: service)
        RepoContainer.addContainer(repo: self)
    }
    
    func setService(service: API) {
        self.service = service
    }
    
    func fetchBeers(page: Int, beerName: String = "", category: String = "") {
        if (category != "" || beerName != "") && page == 1 {
            self.beers.removeAll()
        }
        API().getBeers(page: page, beerName: beerName, category: category) { (response) in
            if let data = try? response?.data {
                let decoder = JSONDecoder()
                let beersDecoded = try? decoder.decode(Beers.self, from: data)
                if let decBeers = beersDecoded?.beers {
                    self.beers += decBeers
                }
                print(beersDecoded?.beers?.count)
            }
        }
    }
    
    private func notifyObservers() {
        for obs in observers {
            obs.notifyObservers(beers: beers)
        }
    }
    
    func getBeers() -> [Beer] {
        return self.beers
    }
    
    func editBeer(beer: Beer, index: Int) {
        self.beers[index] = beer
    }
    
    func deleteBeer(index: Int) {
        self.beers.remove(at: index)
    }
    
    func addBeerRepoObserver(obs: BeerRepoDelegate) {
        self.observers.append(obs)
    }
    
    func removeBeerRepoObserver(obs: BeerRepoDelegate) {
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
