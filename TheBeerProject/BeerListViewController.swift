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

    var beerTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    var header: UIView?
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
            AF.session.getAllTasks { (tasks) in
                tasks.forEach { $0.cancel()}
            }
            beers.removeAll()
            self.beerListViewModel?.fetchBeers(page: page, beerName: query ?? "", category: self.category ?? "")
        }
    }
    
    var category: String? {
        didSet {
            page = 1
            beers.removeAll()
            self.beerListViewModel?.fetchBeers(page: page, beerName: query ?? "", category: self.category ?? "")
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Box"
        configureUI()
        setConstraints()
        
        beerTableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        
        beerListViewModel = BeerListViewModel()
        beerListViewModel!.delegate = self
        beerListViewModel?.fetchBeers(page: self.page)
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        beerTableView.rowHeight = UITableView.automaticDimension
        beerTableView.estimatedRowHeight = 248
        
        setSearchBar()
        setHeaderViewPopular()
        
        refreshControl.tintColor = UIColor.white
        beerTableView.refreshControl = refreshControl
        refreshControl.addTarget(beerTableView, action: #selector(beerTableView.reloadData), for: .valueChanged)
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource, BeerListViewModelDelegate, HeaderSectionViewControllerDelegate {
    func passCategry(category: String) {
        self.category = category
    }
    
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
            self.beerListViewModel?.fetchBeers(page: page, beerName: query ?? "", category: self.category ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroId: String = "cell\(indexPath.section)\(indexPath.row)beerList"
        let beer = beers[indexPath.row]
        let vc: BeerDetailViewController = BeerDetailViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        vc.beer = beer
        
        //set hero
        vc.hero.isEnabled = true
        vc.heroId = heroId
        
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
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

extension BeerListViewController {
    func setHeaderViewPopular() {
        header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 230))
        let childViewController = HeaderSectionViewController()
        childViewController.delegate = self
        childViewController.view.frame = header!.frame
        addChild(childViewController)
        header!.addSubview(childViewController.view)
        didMove(toParent: self)
    }
    
    func configureUI() {
        self.view.addSubview(beerTableView)
        beerTableView.backgroundColor = UIColor(named: "AppMainColor")
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(named: "AppMainColor")

            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setConstraints() {
        beerTableView.translatesAutoresizingMaskIntoConstraints = false
        beerTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        beerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        beerTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        beerTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}


