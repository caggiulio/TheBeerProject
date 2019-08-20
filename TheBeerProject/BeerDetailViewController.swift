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
    
    var beer: Beer?
    var heroId: String?

    @IBOutlet weak var beerDescr: UILabel!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerSubtitle: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if beer != nil {
            beerImage.sd_setImage(with: URL(string: (beer?.imageUrl!)!))
            beerTitle.text = beer?.name
            beerSubtitle.text = beer?.tagline
            beerDescr.text = beer?.description
        }
        
        if heroId != nil {
            self.hero.isEnabled = true
            self.beerImage.hero.id = heroId
        }
    }
    

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
