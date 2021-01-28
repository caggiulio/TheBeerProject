//
//  BeerListViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import HTTPiOSCLient
import Alamofire

class BeerListViewModel: NSObject, BeerRepoDelegate {
    
    weak var beerListViewController: BeerListViewController?
    
    private var beers: [Beer] = [Beer]() {
        didSet {
            self.beerListViewController?.reloadData()
        }
    }
    
    var page: Int = 1
    
    var query: String? {
        didSet {
            page = 1
            search(string: query ?? "", category: self.category)
        }
    }
    
    var category: String = "" {
        didSet {
            self.page = 1
            self.getBeers(page: 1, beerName: query ?? "", category: self.category)
        }
    }
    
    var searchTask: DispatchWorkItem?
    
    override init() {
        super.init()
        BeerRepo.addBeerRepoObserver(obs: self)
    }
    
    func getBeers(page: Int, beerName: String = "", category: String = "") {
        BeerRepo.fetchBeers(page: page, beerName: beerName, category: category)
    }
    
    func search(string: String, category: String) {
        page = 1
        
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            BeerRepo.fetchBeers(page: self?.page ?? 1, beerName: string, category: category)
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    func notifyObservers(beers: [Beer]) {
        self.beers = beers
        page += 1
    }
    
    func getBeersDataCount() -> Int {
        return beers.count
    }
    
    func getBeerAtIndexPath(indexPath: IndexPath) -> Beer {
        return beers[indexPath.row]
    }
}
