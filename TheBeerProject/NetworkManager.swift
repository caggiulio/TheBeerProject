//
//  Networking.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

// enum used for convenience purposes (optional)
public enum ServerURL: String {
    case base = "https://api.punkapi.com/v2/"
}

public class RestClient {
    var baseURL: String
    
    var defaultHeader: HTTPHeaders = [
        "Content-Type": "application/json",
        "x-ratelimit-limit": "3600",
        "x-ratelimit-remaining": "3587"
    ]
    
    public init(baseURL: ServerURL = .base) {
        self.baseURL = baseURL.rawValue
    }
    
    func request(_ method: HTTPMethod, URIString: String, parameters: [String:AnyObject]?, withQuery: Bool, withLoader: Bool,
                 headers: HTTPHeaders = [:]) -> Promise < JSON > {
        return Promise { prom in
            let header = defaultHeader
            let query: String = baseURL+URIString
            
            print(query)
            Alamofire.request(query, method: method,
                              parameters: method == .get ? nil : parameters,
                              encoding: JSONEncoding.default,
                              headers: header).responseJSON { (response) in
                                
                                switch response.result {
                                case .success( _):
                                    let js = JSON(response.data as Any)
                                    prom.fulfill(js)
                                case .failure(let error):
                                    prom.reject(error)
                                }
            }
        }
    }
}
