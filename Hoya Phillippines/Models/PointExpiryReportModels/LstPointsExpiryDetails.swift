

import Foundation
struct LstPointsExpiryDetails : Codable {
	let pointsExpiryDate : String?
	let jPointsExpiryDate : String?
	let pointsGoingtoExpire : Int?

	enum CodingKeys: String, CodingKey {

		case pointsExpiryDate = "pointsExpiryDate"
		case jPointsExpiryDate = "jPointsExpiryDate"
		case pointsGoingtoExpire = "pointsGoingtoExpire"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pointsExpiryDate = try values.decodeIfPresent(String.self, forKey: .pointsExpiryDate)
		jPointsExpiryDate = try values.decodeIfPresent(String.self, forKey: .jPointsExpiryDate)
		pointsGoingtoExpire = try values.decodeIfPresent(Int.self, forKey: .pointsGoingtoExpire)
	}

}
