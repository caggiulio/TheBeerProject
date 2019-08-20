//
//  HeaderSectionViewController.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

class HeaderSectionViewController: UIViewController {

    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    var categories = ["Pilsner, Lager, Caramel"]
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
    
    
}
