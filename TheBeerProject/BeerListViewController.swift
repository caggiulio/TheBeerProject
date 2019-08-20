//
//  ViewController.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit
import PromiseKit
import SDWebImage
import Alamofire
import Hero

class BeerListViewController: UIViewController {

    @IBOutlet weak var beerTableView: UITableView!
    var beerListViewModel: BeerListViewModel?
    var beers: [Beer] = [Beer]() {
        didSet {
            beerTableView.reloadData()
        }
    }
    
    var page: Int = 1
    let search = UISearchController(searchResultsController: nil)
    var query: String? {
        didSet {
            page = 1
            Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
                tasks.forEach { $0.cancel()}
            }
            beers.removeAll()
            beerListViewModel?.fetchBeers(page: page, beerName: query!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Box"
        beerListViewModel = BeerListViewModel()
        beerListViewModel!.delegate = self
        beerListViewModel?.fetchBeers(page: self.page)
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        beerTableView.rowHeight = UITableView.automaticDimension
        beerTableView.estimatedRowHeight = 248
        
        setSearchBar()
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource, BeerListViewModelDelegate {
    func passBeers(beers: [Beer]) {
        if beers.count > 0 {
            for beer in beers {
                self.beers.append(beer)
            }
            page += 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerTableViewCell") as! BeerTableViewCell
        let beer = beers[indexPath.row]
        
        cell.fillCell(beer: beer)
        cell.selectionStyle = .none
        
        //set heroId
        let heroId: String = "cell\(indexPath.section)\(indexPath.row)beerList"
        cell.beerImage.hero.id = heroId
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = beers.count - 1
        if((indexPath.row == lastElement)) {
            self.beerListViewModel?.fetchBeers(page: page, beerName: query ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroId: String = "cell\(indexPath.section)\(indexPath.row)beerList"
        let beer = beers[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "beerDetailViewController") as! BeerDetailViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.beer = beer
        
        //set hero
        vc.hero.isEnabled = true
        vc.heroId = heroId
        
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension BeerListViewController: UISearchBarDelegate {
    func setSearchBar() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = search
        search.searchBar.delegate = self
        search.searchBar.barStyle = .default
        search.searchBar.barTintColor = UIColor.white
        search.searchBar.tintColor = UIColor.white
        search.searchBar.setTextColorAndTextFont(color: .white, font: UIFont.systemFont(ofSize: 12))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setTextColorAndTextFont(color: .white, font: UIFont.systemFont(ofSize: 12))
        
        query = searchText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = query
    }
}


