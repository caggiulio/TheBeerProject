//
//  BeerTableViewCell.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    var beerSubtitle: UILabel = UILabel(frame: .zero)
    var beerDescr: UILabel = UILabel(frame: .zero)
    var beerTitle: UILabel = UILabel(frame: .zero)
    var beerImage: UIImageView = UIImageView(frame: .zero)
    var stackView: UIStackView = UIStackView(frame: .zero)
    
    var beerListCellPresenter: BeerListTableViewCellPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPresenter(presenter: BeerListTableViewCellPresenter) {
        self.beerListCellPresenter = presenter
        beerListCellPresenter?.attachView(view: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        self.contentView.addSubview(beerImage)
        self.contentView.addSubview(stackView)
        
        self.contentView.backgroundColor = UIColor(named: "AppMainColor")
        beerTitle.font = UIFont.boldSystemFont(ofSize: 22)
        beerSubtitle.font = UIFont.boldSystemFont(ofSize: 17)
        beerDescr.font = UIFont.boldSystemFont(ofSize: 15)
        beerTitle.textColor = .white
        beerSubtitle.textColor = .gray
        beerDescr.textColor = .gray
    }
    
    func setConstraints() {
        beerSubtitle.translatesAutoresizingMaskIntoConstraints = false
        beerDescr.translatesAutoresizingMaskIntoConstraints = false
        beerTitle.translatesAutoresizingMaskIntoConstraints = false
        beerImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //IMAGE
        beerImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        beerImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        beerImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        beerImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        beerImage.contentMode = .scaleAspectFit
        
        //STACKVIEW WITH INFO
        stackView.topAnchor.constraint(equalTo: beerImage.topAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: beerImage.heightAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        beerDescr.numberOfLines = 0
        beerDescr.minimumScaleFactor = 0.65
        
        stackView.addArrangedSubview(beerTitle)
        stackView.addArrangedSubview(beerSubtitle)
        stackView.addArrangedSubview(beerDescr)
        
        beerTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        beerSubtitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

extension BeerTableViewCell: BeerListTableViewCellPresenterView {
    func updateUI(beer: Beer) {
        beerImage.sd_setImage(with: URL(string: beer.imageUrl ?? ""))
        beerTitle.text = beer.name
        beerSubtitle.text = beer.tagline
        beerDescr.text = beer.description
    }
}
