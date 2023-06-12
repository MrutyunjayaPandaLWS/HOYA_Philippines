

import Foundation
struct PointExpireReportModel : Codable {
	let lstPointsExpiryDetails : [LstPointsExpiryDetails]?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case lstPointsExpiryDetails = "lstPointsExpiryDetails"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lstPointsExpiryDetails = try values.decodeIfPresent([LstPointsExpiryDetails].self, forKey: .lstPointsExpiryDetails)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
