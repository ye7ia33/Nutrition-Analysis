//
//  StringExtensionTest.swift
//  Nutrition AnalysisTests
//
//  Created by Yahia El-Dow on 03/04/2021.
//

import XCTest
@testable import Nutrition_Analysis

class StringExtensionTests: XCTestCase {

    func testStringWithoutArrayChar() {
        let string = "[ \"DAIRY_FREE\", \"MILK_FREE\", \"PEANUT_FREE\", \"TREE_NUT_FREE\", \"SOY_FREE\", \"FISH_FREE\", \"SHELLFISH_FREE\"]"
        let chacked = string.parseArrayFormatToString().contains("\"") &&
                      string.parseArrayFormatToString().contains("[") &&
                      string.parseArrayFormatToString().contains("]") &&
                      string.parseArrayFormatToString().contains("_") &&
                      string.parseArrayFormatToString().contains("[")
        XCTAssertFalse(chacked, "fail parseing")
    }

}
