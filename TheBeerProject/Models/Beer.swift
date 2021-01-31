

import Foundation
struct Beer : Codable {
	let tagline : String?
	let name : String?
	let target_og : Double?
	let ebc : Double?
	let description : String?
	let ingredients : Ingredients?
	let contributed_by : String?
	let boil_volume : Boil_volume?
	let attenuation_level : Double?
	let ibu : Double?
	let food_pairing : [String]?
	let target_fg : Double?
	let first_brewed : String?
	let abv : Double?
	let image_url : String?
	let brewers_tips : String?
	let id : Double?
	let volume : Volume?
	let method : Method?
	let ph : Double?
	let srm : Double?

	enum CodingKeys: String, CodingKey {

		case tagline = "tagline"
		case name = "name"
		case target_og = "target_og"
		case ebc = "ebc"
		case description = "description"
		case ingredients = "ingredients"
		case contributed_by = "contributed_by"
		case boil_volume = "boil_volume"
		case attenuation_level = "attenuation_level"
		case ibu = "ibu"
		case food_pairing = "food_pairing"
		case target_fg = "target_fg"
		case first_brewed = "first_brewed"
		case abv = "abv"
		case image_url = "image_url"
		case brewers_tips = "brewers_tips"
		case id = "id"
		case volume = "volume"
		case method = "method"
		case ph = "ph"
		case srm = "srm"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		target_og = try values.decodeIfPresent(Double.self, forKey: .target_og)
		ebc = try values.decodeIfPresent(Double.self, forKey: .ebc)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		ingredients = try values.decodeIfPresent(Ingredients.self, forKey: .ingredients)
		contributed_by = try values.decodeIfPresent(String.self, forKey: .contributed_by)
		boil_volume = try values.decodeIfPresent(Boil_volume.self, forKey: .boil_volume)
		attenuation_level = try values.decodeIfPresent(Double.self, forKey: .attenuation_level)
		ibu = try values.decodeIfPresent(Double.self, forKey: .ibu)
		food_pairing = try values.decodeIfPresent([String].self, forKey: .food_pairing)
		target_fg = try values.decodeIfPresent(Double.self, forKey: .target_fg)
		first_brewed = try values.decodeIfPresent(String.self, forKey: .first_brewed)
		abv = try values.decodeIfPresent(Double.self, forKey: .abv)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		brewers_tips = try values.decodeIfPresent(String.self, forKey: .brewers_tips)
		id = try values.decodeIfPresent(Double.self, forKey: .id)
		volume = try values.decodeIfPresent(Volume.self, forKey: .volume)
		method = try values.decodeIfPresent(Method.self, forKey: .method)
		ph = try values.decodeIfPresent(Double.self, forKey: .ph)
		srm = try values.decodeIfPresent(Double.self, forKey: .srm)
	}

}
