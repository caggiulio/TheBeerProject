//
//  CategoryCollectionViewCell.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerCategoryCell: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerCategoryCell.clipsToBounds = true
        containerCategoryCell.layer.cornerRadius = 20
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                containerCategoryCell.backgroundColor = UIColor.init(named: "Gold")
            } else {
                containerCategoryCell.backgroundColor = .darkGray
            }
        }
    }
}
