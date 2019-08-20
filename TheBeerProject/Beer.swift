//
//  Beer.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 20, 2019
//
import Foundation
import SwiftyJSON

struct Beer {

	let id: Int?
	let name: String?
	let tagline: String?
	let firstBrewed: String?
	let description: String?
	let imageUrl: String?
	let abv: Double?
	let ibu: Int?
	let targetFg: Int?
	let targetOg: Int?
	let ebc: Int?
	let srm: Int?
	let ph: Double?
	let attenuationLevel: Int?
	let volume: Volume?
	let boilVolume: BoilVolume?
	let method: Method?
	let ingredients: Ingredients?
	let foodPairing: [String]?
	let brewersTips: String?
	let contributedBy: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		tagline = json["tagline"].stringValue
		firstBrewed = json["first_brewed"].stringValue
		description = json["description"].stringValue
		imageUrl = json["image_url"].stringValue
		abv = json["abv"].doubleValue
		ibu = json["ibu"].intValue
		targetFg = json["target_fg"].intValue
		targetOg = json["target_og"].intValue
		ebc = json["ebc"].intValue
		srm = json["srm"].intValue
		ph = json["ph"].doubleValue
		attenuationLevel = json["attenuation_level"].intValue
		volume = Volume(json["volume"])
		boilVolume = BoilVolume(json["boil_volume"])
		method = Method(json["method"])
		ingredients = Ingredients(json["ingredients"])
		foodPairing = json["food_pairing"].arrayValue.map { $0.stringValue }
		brewersTips = json["brewers_tips"].stringValue
		contributedBy = json["contributed_by"].stringValue
	}

}