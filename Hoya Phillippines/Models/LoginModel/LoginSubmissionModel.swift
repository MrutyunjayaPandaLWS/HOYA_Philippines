

import Foundation
struct LoginSubmissionModel : Codable {
	let userList : [UserList]?
	let objUserDetailedInfo : String?
	let merchantImageDetails : String?
	let lstMerchantImageDetails : String?
	let userId : Int?

	enum CodingKeys: String, CodingKey {

		case userList = "userList"
		case objUserDetailedInfo = "objUserDetailedInfo"
		case merchantImageDetails = "merchantImageDetails"
		case lstMerchantImageDetails = "lstMerchantImageDetails"
		case userId = "userId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userList = try values.decodeIfPresent([UserList].self, forKey: .userList)
		objUserDetailedInfo = try values.decodeIfPresent(String.self, forKey: .objUserDetailedInfo)
		merchantImageDetails = try values.decodeIfPresent(String.self, forKey: .merchantImageDetails)
		lstMerchantImageDetails = try values.decodeIfPresent(String.self, forKey: .lstMerchantImageDetails)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
	}

}
