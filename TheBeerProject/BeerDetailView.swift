//
//  BeerDetailView.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 14/12/20.
//  Copyright © 2020 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import UIKit

extension BeerDetailViewController {
    func configureUI() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.view.addSubview(transparentView)
        self.view.addSubview(containerView)
        self.view.addSubview(beerDescr)
        self.view.addSubview(beerTitle)
        self.view.addSubview(beerSubtitle)
        self.view.addSubview(beerImage)
        self.view.addSubview(infoStackView)
        self.view.addSubview(closeButton)
        
        transparentView.backgroundColor = UIColor(white: 0, alpha: 0.65)
        containerView.backgroundColor = UIColor(named: "AppMainColor")
        beerImage.contentMode = .scaleAspectFit
        
        beerTitle.font = UIFont.boldSystemFont(ofSize: 22)
        beerSubtitle.font = UIFont.boldSystemFont(ofSize: 17)
        beerDescr.font = UIFont.boldSystemFont(ofSize: 15)
        beerTitle.textColor = .white
        beerSubtitle.textColor = .gray
        beerDescr.textColor = .gray
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        beerImage.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        //TRANSPARENTVIEW
        transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        transparentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        transparentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        transparentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //CLOSE BUTTON
        closeButton.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor, constant: -15).isActive = true
        
        //CONTAINER VIEW
        containerView.bottomAnchor.constraint(equalTo: self.transparentView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.transparentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.transparentView.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        
        //IMAGE VIEW
        beerImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
        beerImage.heightAnchor.constraint(equalToConstant: 230).isActive = true
        beerImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        beerImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        //STACKVIEW
        infoStackView.topAnchor.constraint(equalTo: beerImage.topAnchor).isActive = true
        infoStackView.heightAnchor.constraint(equalTo: beerImage.heightAnchor).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: 10).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10).isActive = true
        infoStackView.axis = .vertical
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 5
        
        beerDescr.numberOfLines = 0
        beerDescr.minimumScaleFactor = 0.25
        beerDescr.adjustsFontSizeToFitWidth = true
        
        infoStackView.addArrangedSubview(beerTitle)
        infoStackView.addArrangedSubview(beerSubtitle)
        infoStackView.addArrangedSubview(beerDescr)
        
        beerTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        beerSubtitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
