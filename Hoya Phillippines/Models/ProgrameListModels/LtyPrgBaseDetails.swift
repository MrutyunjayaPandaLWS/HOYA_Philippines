/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LtyPrgBaseDetails : Codable {
	let programName : String?
	let gamifyId : Int?
	let programDesc : String?
	let awardingType : String?
	let startDate : String?
	let endDate : String?
	let trxnStartingDate : String?
	let trxnEndDate : String?
	let awardingTypeId : Int?
	let pointTypeId : Int?
	let conversionCriteriaID : Int?
	let conversionCriteriaValue : Int?
	let behaviourParentId : Int?
	let behaviourChildParentId : Int?
	let jEndDate : String?
	let currency_name : String?
	let iS_Active : Bool?
	let loyaltyImage : String?
	let programVersion : Int?
	let createdDate : String?
	let modifiedDate : String?
	let merchantId : Int?
	let multiplierType : String?
	let multiPlierName : String?
	let awardingRule : String?
	let criteria : String?
	let cat1 : String?
	let prod1 : String?
	let segment : String?
	let fromDate : String?
	let toDate : String?
	let programId : Int?

	enum CodingKeys: String, CodingKey {

		case programName = "programName"
		case gamifyId = "gamifyId"
		case programDesc = "programDesc"
		case awardingType = "awardingType"
		case startDate = "startDate"
		case endDate = "endDate"
		case trxnStartingDate = "trxnStartingDate"
		case trxnEndDate = "trxnEndDate"
		case awardingTypeId = "awardingTypeId"
		case pointTypeId = "pointTypeId"
		case conversionCriteriaID = "conversionCriteriaID"
		case conversionCriteriaValue = "conversionCriteriaValue"
		case behaviourParentId = "behaviourParentId"
		case behaviourChildParentId = "behaviourChildParentId"
		case jEndDate = "jEndDate"
		case currency_name = "currency_name"
		case iS_Active = "iS_Active"
		case loyaltyImage = "loyaltyImage"
		case programVersion = "programVersion"
		case createdDate = "createdDate"
		case modifiedDate = "modifiedDate"
		case merchantId = "merchantId"
		case multiplierType = "multiplierType"
		case multiPlierName = "multiPlierName"
		case awardingRule = "awardingRule"
		case criteria = "criteria"
		case cat1 = "cat1"
		case prod1 = "prod1"
		case segment = "segment"
		case fromDate = "fromDate"
		case toDate = "toDate"
		case programId = "programId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		programName = try values.decodeIfPresent(String.self, forKey: .programName)
		gamifyId = try values.decodeIfPresent(Int.self, forKey: .gamifyId)
		programDesc = try values.decodeIfPresent(String.self, forKey: .programDesc)
		awardingType = try values.decodeIfPresent(String.self, forKey: .awardingType)
		startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
		endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
		trxnStartingDate = try values.decodeIfPresent(String.self, forKey: .trxnStartingDate)
		trxnEndDate = try values.decodeIfPresent(String.self, forKey: .trxnEndDate)
		awardingTypeId = try values.decodeIfPresent(Int.self, forKey: .awardingTypeId)
		pointTypeId = try values.decodeIfPresent(Int.self, forKey: .pointTypeId)
		conversionCriteriaID = try values.decodeIfPresent(Int.self, forKey: .conversionCriteriaID)
		conversionCriteriaValue = try values.decodeIfPresent(Int.self, forKey: .conversionCriteriaValue)
		behaviourParentId = try values.decodeIfPresent(Int.self, forKey: .behaviourParentId)
		behaviourChildParentId = try values.decodeIfPresent(Int.self, forKey: .behaviourChildParentId)
		jEndDate = try values.decodeIfPresent(String.self, forKey: .jEndDate)
		currency_name = try values.decodeIfPresent(String.self, forKey: .currency_name)
		iS_Active = try values.decodeIfPresent(Bool.self, forKey: .iS_Active)
		loyaltyImage = try values.decodeIfPresent(String.self, forKey: .loyaltyImage)
		programVersion = try values.decodeIfPresent(Int.self, forKey: .programVersion)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		modifiedDate = try values.decodeIfPresent(String.self, forKey: .modifiedDate)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		multiplierType = try values.decodeIfPresent(String.self, forKey: .multiplierType)
		multiPlierName = try values.decodeIfPresent(String.self, forKey: .multiPlierName)
		awardingRule = try values.decodeIfPresent(String.self, forKey: .awardingRule)
		criteria = try values.decodeIfPresent(String.self, forKey: .criteria)
		cat1 = try values.decodeIfPresent(String.self, forKey: .cat1)
		prod1 = try values.decodeIfPresent(String.self, forKey: .prod1)
		segment = try values.decodeIfPresent(String.self, forKey: .segment)
		fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
		toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
		programId = try values.decodeIfPresent(Int.self, forKey: .programId)
	}

}