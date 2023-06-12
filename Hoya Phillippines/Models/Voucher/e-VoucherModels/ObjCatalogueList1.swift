

import Foundation
struct ObjCatalogueList1 : Codable {
    let catalogueID, catalogueName: Int
        let productName: String
        let productImage: String
        let productImageServerPath: String?
        let productCode, productDesc: String
        let pointsRequired: Int
        let hasPartialPayment: Bool
        let partialPaymentCash: Int
        let deliveryType: String?
        let noOfQuantity, noOfPointsDebit, noOfCartQuantity, totalCash: Int
        let redemptionRefno: String?
        let redemptionID: Int
        let loyaltyID, redemptionDate, jRedemptionDate: String?
        let vendorID: Int
        let vendorName: String
        let isPlanner: Bool
        let redemptionPlannerID, pointBalance: Int
        let averageEarning, actualRedemptionDate: String?
        let pointReqToAcheiveProduct: Int
        let minPoints, maxPoints, barcode: String?
        let pointRedem, productType, countryID: Int
        let commandName: String?
        let activeStatus: Bool
        let msqa, redeemablePointBalance, minimumStockQunty, redeemableEncashBalance: Int
        let redeemableAverageEarning: String?
        let selectedStatus: Int
        let isCash: Bool
        let countryCurrencyCode: String?
        let pointsPerUnit, cashPerUnit: Int
        let approverName, expectedDelivery, additionalRemarks: String?
        let isApproved: Bool
        let isPopularCount: Int
        let createdBy, expiryDate: String?
        let expiryOn, categoryID, locationID, cashValue: Int
        let redemptionStatus, greaterAvgCash, avgGreaterExpDate, dailyAvgCash: String?
        let avgExpDate, lesserAvgCash, avgLesserExpDate, segmentDetails: String?
        let dreamGiftID, redemptionTypeID, catalogueType: Int
        let multipleRedIDS, memberName, mobile, createdDate: String?
        let plannerStatus: String?
        let totalRow, redeemableAverageEarning12, redeemableAverageEarning6: Int
        let catalougeBrandName: String?
        let isAddPlanner: Bool
        let comments: String?
        let customerCartID, catalogueIDExist, catalogueRedemptionIDExists: Int
        let categoryName: String?
        let sumOfTotalPointsRequired: Int
        let mrp: String?
        let schemeID: Int
        let domainName: String?
        let tdsPercentage, proposedTDS, applicableTds, sumOfRedeemableWithTDS: Int
        let isRedeemable, isCartRedeemable, result: Int
        let averageEarningperDay, daysRequiredToAchieveGoal, averageEarningPerMonth, monthsRequiredToAchieveGoal: String?
        let achievementDateMonthWize, achievementDateDayWize, redeemedCatalogueType: String?
        let catogoryID, catalogueBrandID: Int
        let catalogueBrandName, catalogueBrandCode, catalogueBrandDesc, brandTermsAndConditions: String?
        let catogoryName: String
        let subCategoryID: Int
        let subCategoryName: String?
        let categoryParentID, merchantID: Int
        let merchantName: String
        let status: Int
        let fromDate, toDate, jFromDate, jToDate: String?
        let colorID: Int
        let colorName, colorCode, modelName: String?
        let modelID, userAccess: Int
        let catogoryImage: String?
        let termsCondition: String
        let token: String?
        let actorID: Int
        let isActive: Bool
        let actorRole: String?
        let actionType: Int

        enum CodingKeys: String, CodingKey {
            case catalogueID = "catalogueId"
            case catalogueName, productName, productImage, productImageServerPath, productCode, productDesc, pointsRequired, hasPartialPayment, partialPaymentCash, deliveryType, noOfQuantity, noOfPointsDebit, noOfCartQuantity, totalCash, redemptionRefno
            case redemptionID = "redemptionId"
            case loyaltyID = "loyaltyId"
            case redemptionDate, jRedemptionDate
            case vendorID = "vendorId"
            case vendorName, isPlanner
            case redemptionPlannerID = "redemptionPlannerId"
            case pointBalance, averageEarning, actualRedemptionDate, pointReqToAcheiveProduct
            case minPoints = "min_points"
            case maxPoints = "max_points"
            case barcode, pointRedem
            case productType = "product_type"
            case countryID, commandName, activeStatus, msqa, redeemablePointBalance, minimumStockQunty, redeemableEncashBalance, redeemableAverageEarning, selectedStatus, isCash, countryCurrencyCode, pointsPerUnit, cashPerUnit, approverName, expectedDelivery, additionalRemarks, isApproved, isPopularCount, createdBy, expiryDate, expiryOn, categoryID
            case locationID = "locationId"
            case cashValue, redemptionStatus, greaterAvgCash, avgGreaterExpDate, dailyAvgCash, avgExpDate, lesserAvgCash, avgLesserExpDate, segmentDetails
            case dreamGiftID = "dreamGiftId"
            case redemptionTypeID = "redemptionTypeId"
            case catalogueType
            case multipleRedIDS = "multipleRedIds"
            case memberName, mobile, createdDate, plannerStatus
            case totalRow = "total_Row"
            case redeemableAverageEarning12, redeemableAverageEarning6, catalougeBrandName, isAddPlanner, comments
            case customerCartID = "customerCartId"
            case catalogueIDExist = "catalogueIdExist"
            case catalogueRedemptionIDExists = "catalogueRedemptionIdExists"
            case categoryName, sumOfTotalPointsRequired, mrp
            case schemeID = "schemeId"
            case domainName, tdsPercentage, proposedTDS, applicableTds, sumOfRedeemableWithTDS
            case isRedeemable = "is_Redeemable"
            case isCartRedeemable = "is_CartRedeemable"
            case result, averageEarningperDay, daysRequiredToAchieveGoal, averageEarningPerMonth, monthsRequiredToAchieveGoal, achievementDateMonthWize, achievementDateDayWize, redeemedCatalogueType
            case catogoryID = "catogoryId"
            case catalogueBrandID = "catalogueBrandId"
            case catalogueBrandName, catalogueBrandCode, catalogueBrandDesc, brandTermsAndConditions, catogoryName, subCategoryID, subCategoryName, categoryParentID
            case merchantID = "merchantId"
            case merchantName, status, fromDate, toDate, jFromDate, jToDate
            case colorID = "color_Id"
            case colorName = "color_Name"
            case colorCode = "color_Code"
            case modelName
            case modelID = "modelId"
            case userAccess, catogoryImage, termsCondition, token
            case actorID = "actorId"
            case isActive, actorRole, actionType
        }
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }

