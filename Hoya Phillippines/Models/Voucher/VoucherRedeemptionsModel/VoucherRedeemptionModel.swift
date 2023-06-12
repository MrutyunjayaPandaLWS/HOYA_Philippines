

import Foundation
struct VoucherRedeemptionModel : Codable {
	let message : String?
	let exceptionMessage : String?
	let exceptionType : String?
	let stackTrace : String?

	enum CodingKeys: String, CodingKey {

		case message = "message"
		case exceptionMessage = "exceptionMessage"
		case exceptionType = "exceptionType"
		case stackTrace = "stackTrace"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		exceptionMessage = try values.decodeIfPresent(String.self, forKey: .exceptionMessage)
		exceptionType = try values.decodeIfPresent(String.self, forKey: .exceptionType)
		stackTrace = try values.decodeIfPresent(String.self, forKey: .stackTrace)
	}

}
