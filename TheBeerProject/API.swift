//
//  API.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

public class API: RestClient {
    
    init() {
        super.init(baseURL: .base)
    }
    
    func getBeers(page: Int, beerName: String) -> Promise <JSON> {
        if beerName != "" {
             return request(.get, URIString: "beers?page=\(page)&beer_name=\(beerName)&per_page=25", parameters: nil, withQuery: false, withLoader: false)
        } else {
             return request(.get, URIString: "beers?page=\(page)&per_page=25", parameters: nil, withQuery: false, withLoader: false)
        }
    }
}
