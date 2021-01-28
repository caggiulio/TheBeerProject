//
//  BeerDetailViewController.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit
import Hero

class BeerDetailViewController: UIViewController {
    
    var beerDetailViewModel: BeerDetailViewModel?
    var heroId: String?

    var containerView: UIView = UIView(frame: .zero)
    var infoStackView: UIStackView = UIStackView(frame: .zero)
    
    var beerDescr: UILabel = UILabel(frame: .zero)
    var beerTitle: UILabel = UILabel(frame: .zero)
    var beerSubtitle: UILabel = UILabel(frame: .zero)
    var beerImage: UIImageView = UIImageView(frame: .zero)
    var transparentView: UIView = UIView(frame: .zero)
    var closeButton: UIButton = UIButton(frame: .zero)
    
    init(viewModel: BeerDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        setViewModel(vm: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(vm: BeerDetailViewModel) {
        self.beerDetailViewModel = vm
        self.beerDetailViewModel?.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHero()
        configureUI()
        setConstraints()
    }
    

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BeerDetailViewController {
    func setHero() {
        if heroId != nil {
            self.hero.isEnabled = true
            self.beerImage.hero.id = heroId
        }
    }
}
