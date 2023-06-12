

import Foundation
struct OtpModel : Codable {
	let adminList : String?
	let merchantEmailSMSDetails : String?
	let merchantEmailSMSParameterDetails : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case adminList = "adminList"
		case merchantEmailSMSDetails = "merchantEmailSMSDetails"
		case merchantEmailSMSParameterDetails = "merchantEmailSMSParameterDetails"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adminList = try values.decodeIfPresent(String.self, forKey: .adminList)
		merchantEmailSMSDetails = try values.decodeIfPresent(String.self, forKey: .merchantEmailSMSDetails)
		merchantEmailSMSParameterDetails = try values.decodeIfPresent(String.self, forKey: .merchantEmailSMSParameterDetails)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
