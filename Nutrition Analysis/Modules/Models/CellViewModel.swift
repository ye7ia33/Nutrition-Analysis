//
//  NutrientsCellViewModel.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 01/04/2021.
//

import Foundation

struct NutrientsCellViewModel {
    let title: String
    let quantity: String
    let unit: String
}

extension NutrientsCellViewModel {
    init(nutrient: Nutrients) {
        self.title = nutrient.label ?? ""
        self.quantity = String(format:"%.2f", (nutrient.quantity ?? 0.0))
        self.unit = nutrient.unit ?? ""
    }
}

struct SummaryViewCellModel {
    let totalCalories: String
    let dietLabel: String
    let healthLabel: String
}

extension SummaryViewCellModel {
    init(calories: String = "", diet: String = "", healthLabel: String = "") {
        self.totalCalories = calories
        self.dietLabel = diet.parseArrayFormatToString()
        self.healthLabel = healthLabel.parseArrayFormatToString()
    }
}
