//
//  Recipe.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import Foundation
struct Recipe: Codable {
    let uri: String?
    let yield: Double?
    let calories: Int?
    let dietLabels: [String]?
    let healthLabels: [String]?
    let cautions: [String]?
    let totalNutrients: [String: Nutrients]?
    private (set) var nutrients: [Nutrients]?
    enum CodingKeys: String, CodingKey {
        case uri = "uri"
        case yield = "yield"
        case calories = "calories"
        case dietLabels = "dietLabels"
        case healthLabels = "healthLabels"
        case cautions = "cautions"
        case totalNutrients = "totalNutrients"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
        yield = try values.decodeIfPresent(Double.self, forKey: .yield)
        calories = try values.decodeIfPresent(Int.self, forKey: .calories)
        dietLabels = try values.decodeIfPresent([String].self, forKey: .dietLabels)
        healthLabels = try values.decodeIfPresent([String].self, forKey: .healthLabels)
        cautions = try values.decodeIfPresent([String].self, forKey: .cautions)
        totalNutrients = try values.decodeIfPresent([String: Nutrients].self, forKey: .totalNutrients)
        
        self.nutrients = totalNutrients?.compactMap({ (key, values) in
            return values
        })
        
    }
}

struct Nutrients: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
    
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case quantity = "quantity"
        case unit = "unit"
    }
    
    init() {
        self.label = ""
        self.quantity = 0
        self.unit = ""
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        quantity = try values.decodeIfPresent(Double.self, forKey: .quantity)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }
}
