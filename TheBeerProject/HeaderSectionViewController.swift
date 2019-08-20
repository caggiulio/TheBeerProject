//
//  HeaderSectionViewController.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

protocol HeaderSectionViewControllerDelegate: AnyObject {
    func passCategry(category: String)
}

class HeaderSectionViewController: UIViewController {

    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    weak var delegate: HeaderSectionViewControllerDelegate?
    
    var categories = ["All", "Pilsner", "Lager", "Ale", "Amber", "Dark", "Brown", "Cream", "Red", "Golden", "Fruit", "Honey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderView()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension HeaderSectionViewController {
    func setHeaderView() {
        offersView.clipsToBounds = true
        offersView.layer.cornerRadius = 20
    }
}

extension HeaderSectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryName.text = category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.delegate?.passCategry(category: category)
    }
}
