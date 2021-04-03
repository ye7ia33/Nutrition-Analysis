//
//  SummaryViewModelTests.swift
//  Nutrition AnalysisTests
//
//  Created by Yahia El-Dow on 03/04/2021.
//

import XCTest
import RxSwift
@testable import Nutrition_Analysis

class SummaryViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()

    let titleTestData = "Fresh Ham Roasted With Rye Bread and Dried Fruit Stuffing"
    let ingTestData =  [
        "1 fresh ham, about 18 pounds, prepared by your butcher (See Step 1)\",",
        "7 cloves garlic, minced",
        "1 tablespoon caraway seeds, crushed",
        "4 teaspoons salt",
        "Freshly ground pepper to taste",
        "1 teaspoon olive oil",
        "1 medium onion, peeled and chopped",
        "3 cups sourdough rye bread, cut into 1/2-inch cubes",
        "1 1/4 cups coarsely chopped pitted prunes",
        "1 1/4 cups coarsely chopped dried apricots",
        "1 large tart apple, peeled, cored and cut into 1/2-inch cubes",
        "2 teaspoons chopped fresh rosemary",
        "1 egg, lightly beaten",
        "1 cup chicken broth, homemade or low-sodium canned"
    ]
    
    func testResponse() {
        let expectNormal = expectation(description: "Recipe contains a normal cell")
        AnalysisServices().getAnalysisBy(title: titleTestData, ingr: ingTestData).subscribe( onNext: { recipe in
            XCTAssertNotNil(recipe)
            XCTAssertGreaterThan(recipe?.cautions?.count ?? 0, 0)
            XCTAssertGreaterThan(recipe?.calories ?? 0, 0)
            }, onError: { error in
                dLog(error)
                XCTAssertThrowsError(error.asAFError(orFailWith: "Error!"))
            }
        ).disposed(by: disposeBag)
        wait(for: [expectNormal], timeout: 5)
    }
    
   func testViewModelWhereDataIsEmpty()  {
        let vm = SummaryViewModel("", ingr: [])
        _ = vm.nutrientsCells.subscribe(onNext: {
            let cellIsError: Bool
            if case.some(.error(message: _)) = $0.first {
                cellIsError = true
            } else {
                cellIsError = false
            }
            XCTAssertTrue(cellIsError)
        }).dispose()
   }

    func testSuccessfulInit() {
        let summary = SummaryViewCellModel(totalCalories: "100", dietLabel: "Test Diet Label", healthLabel: "Test Health Label")
        XCTAssertNotNil(summary)
    }
    
    func testSuccessEmptyData() {
        XCTAssertNotNil(SummaryViewCellModel())
    }
    
    
}
