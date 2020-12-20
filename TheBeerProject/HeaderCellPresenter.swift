//
//  HeaderCellPresenter.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

protocol HeaderCellPresenterDelegate: NSObject {
    func updateUI(category: String?)
}

class HeaderCellPresenter: NSObject {
    
    weak var delegate: HeaderCellPresenterDelegate? {
        didSet {
            delegate?.updateUI(category: category)
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
}
