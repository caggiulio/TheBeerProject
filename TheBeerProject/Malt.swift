//
//  Malt.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Malt {

	let name: String?
	let amount: Amount?

	init(_ json: JSON) {
		name = json["name"].stringValue
		amount = Amount(json["amount"])
	}

}