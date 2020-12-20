//
//  HeaderCellViewModel.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

class HeaderCellViewModel: NSObject {
    
    var headerCellController: CategoryCollectionViewCell? {
        didSet {
            updateUI()
        }
    }
    var category: String?
    
    init(category: String) {
        super.init()
        setCategory(category: category)
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    func updateUI() {
        headerCellController?.categoryName.text = category
    }
    
}
