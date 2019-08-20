//
//  BeerTableViewCell.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var beerSubtitle: UILabel!
    @IBOutlet weak var beerDescr: UILabel!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(beer: Beer) {
        self.beerImage.sd_setImage(with: URL(string: beer.imageUrl!))
        self.beerTitle.text = beer.name
        self.beerSubtitle.text = beer.tagline
        self.beerDescr.text = beer.description
    }
}
