//
//  EdamamResponse.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import Foundation

// MARK: - EdamamResponse
struct EdamamResponse: Codable {
    let uri: String
    let calories, totalWeight: Int
    let dietLabels, healthLabels, cautions: [String]
    let totalNutrients, totalDaily: [String: TotalDaily]
    let totalNutrientsKCal: TotalNutrientsKCal
}

// MARK: - TotalDaily
struct TotalDaily: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - TotalNutrientsKCal
struct TotalNutrientsKCal: Codable {
    let enercKcal, procntKcal, fatKcal, chocdfKcal: TotalDaily

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case procntKcal = "PROCNT_KCAL"
        case fatKcal = "FAT_KCAL"
        case chocdfKcal = "CHOCDF_KCAL"
    }
}
