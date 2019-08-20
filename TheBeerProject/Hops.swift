//
//  Hops.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Hops {

	let name: String?
	let amount: Amount?
	let add: String?
	let attribute: String?

	init(_ json: JSON) {
		name = json["name"].stringValue
		amount = Amount(json["amount"])
		add = json["add"].stringValue
		attribute = json["attribute"].stringValue
	}

}