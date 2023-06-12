

import Foundation
struct My_EarningsModels : Codable {
	let customerBasicInfoListJson : [CustomerBasicInfoListJson]?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case customerBasicInfoListJson = "customerBasicInfoListJson"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		customerBasicInfoListJson = try values.decodeIfPresent([CustomerBasicInfoListJson].self, forKey: .customerBasicInfoListJson)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
