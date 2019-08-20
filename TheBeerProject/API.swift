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
    
    func getBeers(page: Int, beerName: String, category: String) -> Promise <JSON> {
        var uri = "beers?page=\(page)&per_page=25"
        if category != "" && category != "All" {
            uri.append("&malt=\(category)")
        }
        if beerName != "" {
             uri.append("&beer_name=\(beerName)")
             return request(.get, URIString: uri, parameters: nil, withQuery: false, withLoader: false)
        }
        
        return request(.get, URIString: uri, parameters: nil, withQuery: false, withLoader: false)
    }
}
