

import Foundation
struct PointExpireReportModel : Codable {
    let sumOfEarnedPoints: Int?
    let sumOfRedeemedPoints: Int?
    let sumOfExpiredPoints: Int?
    let sumOfAvailablePoints: Int?
    let lstPointsExpiryDetails : [LstPointsExpiryDetails]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case lstPointsExpiryDetails = "lstPointsExpiryDetails"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
        case sumOfEarnedPoints = "sumOfEarnedPoints"
        case sumOfRedeemedPoints = "sumOfRedeemedPoints"
        case sumOfExpiredPoints = "sumOfExpiredPoints"
        case sumOfAvailablePoints = "sumOfAvailablePoints"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstPointsExpiryDetails = try values.decodeIfPresent([LstPointsExpiryDetails].self, forKey: .lstPointsExpiryDetails)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
        sumOfEarnedPoints = try values.decodeIfPresent(Int.self, forKey: .sumOfEarnedPoints)
        sumOfRedeemedPoints = try values.decodeIfPresent(Int.self, forKey: .sumOfRedeemedPoints)
        sumOfExpiredPoints = try values.decodeIfPresent(Int.self, forKey: .sumOfExpiredPoints)
        sumOfAvailablePoints = try values.decodeIfPresent(Int.self, forKey: .sumOfAvailablePoints)
    }

}
