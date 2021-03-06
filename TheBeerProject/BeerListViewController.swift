//
//  ViewController.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import Hero

class BeerListViewController: UIViewController {

    var beerTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    var header: UIView?
    var beerListPresenter: BeerListPresenter?
    
    let search = UISearchController(searchResultsController: nil)
    
    private let refreshControl = UIRefreshControl()
    
    init(presenter: BeerListPresenter) {
        super.init(nibName: nil, bundle: nil)
        setPresenter(presenter: presenter)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPresenter(presenter: BeerListPresenter) {
        beerListPresenter = presenter
        beerListPresenter?.attachView(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Box"
        configureUI()
        setConstraints()
        
        beerTableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        
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
    
    func reloadData() {
        self.beerTableView.reloadData()
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource, HeaderSectionViewControllerDelegate {
    func passCategry(category: String) {
        beerListPresenter?.category = category
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerListPresenter?.getBeersDataCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerTableViewCell") as! BeerTableViewCell
        
        if let beer = beerListPresenter?.getBeerAtIndexPath(indexPath: indexPath) {
            let cellPresenter = BeerListTableViewCellPresenter(beer: beer)
            cell.setPresenter(presenter: cellPresenter)
        }
        
        cell.selectionStyle = .none
        
        //set heroId
        let heroId: String = "cell\(indexPath.section)\(indexPath.row)beerList"
        cell.beerImage.hero.id = heroId
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = ((beerListPresenter?.getBeersDataCount() ?? 0) - 1)
        if((indexPath.row == lastElement)) && ((beerListPresenter?.getBeersDataCount() ?? 0) > 2) {
            self.beerListPresenter?.getBeers(page: beerListPresenter?.page ?? 0, beerName: self.beerListPresenter?.query ?? "", category: self.beerListPresenter?.category ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroId: String = "cell\(indexPath.section)\(indexPath.row)beerList"
        if let beer = beerListPresenter?.getBeerAtIndexPath(indexPath: indexPath) {
            let assembler: BeerDetailAssmblerInjector = BeerDetailAssembler()
            let vc: BeerDetailViewController = assembler.resolve(beer: beer)
            vc.modalPresentationStyle = .overFullScreen
            
            //set hero
            vc.hero.isEnabled = true
            vc.heroId = heroId
            
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
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
        
        beerListPresenter?.query = searchText
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

extension BeerListViewController: BeerListPresenterView {
    func reload() {
        self.reloadData()
    }
}
