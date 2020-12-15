//
//  API.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import HTTPiOSCLient

public class API: NSObject {
    
    override init() {
        
    }
    
    func getBeers(page: Int, beerName: String, category: String, completion: @escaping (FalconResponse?) -> ()) {
        var uri = "beers?page=\(page)&per_page=25"
        if category != "" && category != "All" {
            uri.append("&malt=\(category)")
        }
        if beerName != "" {
             uri.append("&beer_name=\(beerName)")
             Falcon.request(url: uri, method: .get) { (result) in
                switch result {
                case let .success(response):
                    completion(response)
                case let .error(response, _):
                    completion(response)
                }
            }
        } else {
            Falcon.request(url: uri, method: .get) { (result) in
               switch result {
               case let .success(response):
                   completion(response)
               case let .error(response, _):
                   completion(response)
               }
           }
        }
    }
}
