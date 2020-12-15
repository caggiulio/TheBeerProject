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

    var offersView: UIView = UIView(frame: .zero)
    var categoryCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    weak var delegate: HeaderSectionViewControllerDelegate?
    
    var categories = ["All", "Pilsner", "Lager", "Ale", "Amber", "Dark", "Brown", "Cream", "Red", "Golden", "Fruit", "Honey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.view.addSubview(categoryCollection)
        categoryCollection.setCollectionViewLayout(layout, animated: false)
        categoryCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCollectionViewCell")
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
                
        configureUI()
        setConstraints()
    }
}

extension HeaderSectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryName.text = category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.delegate?.passCategry(category: category)
    }
    
    func configureUI() {
        self.view.addSubview(offersView)
        
        offersView.backgroundColor = UIColor(named: "Gold")
        offersView.clipsToBounds = true
        offersView.layer.cornerRadius = 20
        
        categoryCollection.backgroundColor = UIColor(named: "AppMainColor")
    }
    
    func setConstraints() {
        offersView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollection.translatesAutoresizingMaskIntoConstraints = false
        
        //OFFERS VIEW
        offersView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        offersView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        offersView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        offersView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //COLLECTIONVIEW
        categoryCollection.topAnchor.constraint(equalTo: self.offersView.bottomAnchor, constant: 10).isActive = true
        categoryCollection.heightAnchor.constraint(equalToConstant: 80).isActive = true
        categoryCollection.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
}
