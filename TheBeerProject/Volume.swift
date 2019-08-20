//
//  Volume.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Volume {

	let value: Int?
	let unit: String?

	init(_ json: JSON) {
		value = json["value"].intValue
		unit = json["unit"].stringValue
	}

}