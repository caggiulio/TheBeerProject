//
//  HeaderCellPresenter.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation

protocol HeaderCellPresenterView: NSObject {
    func updateUI(category: String?)
}

class HeaderCellPresenter: NSObject {
    
    weak var view: HeaderCellPresenterView? {
        didSet {
            view?.updateUI(category: category)
        }
    }
    
    func attachView(view: HeaderCellPresenterView) {
        self.view = view
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
