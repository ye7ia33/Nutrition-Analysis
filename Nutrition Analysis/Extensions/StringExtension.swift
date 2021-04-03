//
//  StringExtension.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 03/04/2021.
//

import Foundation
extension String {
    
    func parseArrayFormatToString() -> String{
        return self.replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "\n")
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: "_", with: " ").capitalized
    }
}
