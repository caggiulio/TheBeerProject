//
//  Fermentation.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Fermentation {

	let temp: Temp?

	init(_ json: JSON) {
		temp = Temp(json["temp"])
	}

}