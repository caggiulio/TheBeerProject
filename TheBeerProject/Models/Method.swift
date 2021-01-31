

import Foundation
struct Method : Codable {
	let twist : String?
	let mash_temp : [Mash_temp]?
	let fermentation : Fermentation?

	enum CodingKeys: String, CodingKey {

		case twist = "twist"
		case mash_temp = "mash_temp"
		case fermentation = "fermentation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		twist = try values.decodeIfPresent(String.self, forKey: .twist)
		mash_temp = try values.decodeIfPresent([Mash_temp].self, forKey: .mash_temp)
		fermentation = try values.decodeIfPresent(Fermentation.self, forKey: .fermentation)
	}

}
