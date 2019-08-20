//
//  MashTemp.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct MashTemp {

	let temp: Temp?
	let duration: Int?

	init(_ json: JSON) {
		temp = Temp(json["temp"])
		duration = json["duration"].intValue
	}

}