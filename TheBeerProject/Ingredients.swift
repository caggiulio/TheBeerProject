//
//  Ingredients.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Ingredients {

	let malt: [Malt]?
	let hops: [Hops]?
	let yeast: String?

	init(_ json: JSON) {
		malt = json["malt"].arrayValue.map { Malt($0) }
		hops = json["hops"].arrayValue.map { Hops($0) }
		yeast = json["yeast"].stringValue
	}

}