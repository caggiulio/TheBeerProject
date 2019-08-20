//
//  Method.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Method {

	let mashTemp: [MashTemp]?
	let fermentation: Fermentation?
	let twist: Any?

	init(_ json: JSON) {
		mashTemp = json["mash_temp"].arrayValue.map { MashTemp($0) }
		fermentation = Fermentation(json["fermentation"])
		twist = json["twist"]
	}

}