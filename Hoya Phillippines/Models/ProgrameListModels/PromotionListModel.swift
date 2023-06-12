/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct PromotionListModel : Codable {
	let ltyPrgBaseDetails : [LtyPrgBaseDetails]?
	let ltyProgDetails : String?
	let ltyProgFeeRewardDetails : String?
	let ltyProgFilterDetails : String?
	let lstLtyProductRuleDetails : [String]?
	let lstLtyTieredAwardFilterDetails : String?
	let lstLtyProgLocationDetails : String?
	let lstLtyProgSubFilterBehaviour : String?
	let lstLtyProgTxnChannelDetails : String?
	let lstLtyProgPaymentModeDetails : String?
	let lstLtyProgFestivalDetails : String?
	let lstLtyProgSpecificDaysDetails : String?
	let lstLtyPointsExpiryFilter : String?
	let activeType : String?
	let programContribution : Double?
	let lstLtyProductRuleTieredDetails : String?
	let lstProductBulkRule : String?
	let lstLtyAwardBasisUOM : String?
	let loyaltyProgramMemberMapping : String?
	let lstProgramBehaviour : String?
	let ltyProductHierachyRuleList : String?
	let walletList : String?
	let walletHierarchyList : String?
	let ltyWalletProductHierachyConfgRuleList : String?
	let walletHierarchyAwardList : String?
	let ltyWalletProductHierachyAwardRuleList : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case ltyPrgBaseDetails = "ltyPrgBaseDetails"
		case ltyProgDetails = "ltyProgDetails"
		case ltyProgFeeRewardDetails = "ltyProgFeeRewardDetails"
		case ltyProgFilterDetails = "ltyProgFilterDetails"
		case lstLtyProductRuleDetails = "lstLtyProductRuleDetails"
		case lstLtyTieredAwardFilterDetails = "lstLtyTieredAwardFilterDetails"
		case lstLtyProgLocationDetails = "lstLtyProgLocationDetails"
		case lstLtyProgSubFilterBehaviour = "lstLtyProgSubFilterBehaviour"
		case lstLtyProgTxnChannelDetails = "lstLtyProgTxnChannelDetails"
		case lstLtyProgPaymentModeDetails = "lstLtyProgPaymentModeDetails"
		case lstLtyProgFestivalDetails = "lstLtyProgFestivalDetails"
		case lstLtyProgSpecificDaysDetails = "lstLtyProgSpecificDaysDetails"
		case lstLtyPointsExpiryFilter = "lstLtyPointsExpiryFilter"
		case activeType = "activeType"
		case programContribution = "programContribution"
		case lstLtyProductRuleTieredDetails = "lstLtyProductRuleTieredDetails"
		case lstProductBulkRule = "lstProductBulkRule"
		case lstLtyAwardBasisUOM = "lstLtyAwardBasisUOM"
		case loyaltyProgramMemberMapping = "loyaltyProgramMemberMapping"
		case lstProgramBehaviour = "lstProgramBehaviour"
		case ltyProductHierachyRuleList = "ltyProductHierachyRuleList"
		case walletList = "walletList"
		case walletHierarchyList = "walletHierarchyList"
		case ltyWalletProductHierachyConfgRuleList = "ltyWalletProductHierachyConfgRuleList"
		case walletHierarchyAwardList = "walletHierarchyAwardList"
		case ltyWalletProductHierachyAwardRuleList = "ltyWalletProductHierachyAwardRuleList"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ltyPrgBaseDetails = try values.decodeIfPresent([LtyPrgBaseDetails].self, forKey: .ltyPrgBaseDetails)
		ltyProgDetails = try values.decodeIfPresent(String.self, forKey: .ltyProgDetails)
		ltyProgFeeRewardDetails = try values.decodeIfPresent(String.self, forKey: .ltyProgFeeRewardDetails)
		ltyProgFilterDetails = try values.decodeIfPresent(String.self, forKey: .ltyProgFilterDetails)
		lstLtyProductRuleDetails = try values.decodeIfPresent([String].self, forKey: .lstLtyProductRuleDetails)
		lstLtyTieredAwardFilterDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyTieredAwardFilterDetails)
		lstLtyProgLocationDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProgLocationDetails)
		lstLtyProgSubFilterBehaviour = try values.decodeIfPresent(String.self, forKey: .lstLtyProgSubFilterBehaviour)
		lstLtyProgTxnChannelDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProgTxnChannelDetails)
		lstLtyProgPaymentModeDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProgPaymentModeDetails)
		lstLtyProgFestivalDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProgFestivalDetails)
		lstLtyProgSpecificDaysDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProgSpecificDaysDetails)
		lstLtyPointsExpiryFilter = try values.decodeIfPresent(String.self, forKey: .lstLtyPointsExpiryFilter)
		activeType = try values.decodeIfPresent(String.self, forKey: .activeType)
		programContribution = try values.decodeIfPresent(Double.self, forKey: .programContribution)
		lstLtyProductRuleTieredDetails = try values.decodeIfPresent(String.self, forKey: .lstLtyProductRuleTieredDetails)
		lstProductBulkRule = try values.decodeIfPresent(String.self, forKey: .lstProductBulkRule)
		lstLtyAwardBasisUOM = try values.decodeIfPresent(String.self, forKey: .lstLtyAwardBasisUOM)
		loyaltyProgramMemberMapping = try values.decodeIfPresent(String.self, forKey: .loyaltyProgramMemberMapping)
		lstProgramBehaviour = try values.decodeIfPresent(String.self, forKey: .lstProgramBehaviour)
		ltyProductHierachyRuleList = try values.decodeIfPresent(String.self, forKey: .ltyProductHierachyRuleList)
		walletList = try values.decodeIfPresent(String.self, forKey: .walletList)
		walletHierarchyList = try values.decodeIfPresent(String.self, forKey: .walletHierarchyList)
		ltyWalletProductHierachyConfgRuleList = try values.decodeIfPresent(String.self, forKey: .ltyWalletProductHierachyConfgRuleList)
		walletHierarchyAwardList = try values.decodeIfPresent(String.self, forKey: .walletHierarchyAwardList)
		ltyWalletProductHierachyAwardRuleList = try values.decodeIfPresent(String.self, forKey: .ltyWalletProductHierachyAwardRuleList)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
