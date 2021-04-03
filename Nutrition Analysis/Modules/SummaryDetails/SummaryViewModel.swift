//
//  SummaryViewModel.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum TableViewCellType {
    case normalSummaryCell(cellViewModel: SummaryViewCellModel)
    case normalNutrientsCell(cellViewModel: NutrientsCellViewModel)
    case error(message: String)
    case empty
}

private enum DataPresnet: String, CaseIterable {
    case fat = "FAT"
    case cholesterol = "CHOLE"
    case sodium = "NA"
    case fiber = "FIBTG"
    case sugars = "SUGAR"
    case protein = "PROCNT"
    case vitaminK = "VITK1"
    case vitaminA = "VITA_RAE"
    case vitaminD = "VITD"
    case vitaminB6 = "VITB6A"
    case vitaminB12 = "VITB12"
    case vitaminE = "TOCPHA"
    case vitaminC = "VITC"
    case calcium = "CA"
    case iron = "FE"
    case potassium = "K"
}

class SummaryViewModel {
    var nutrientsCells: Observable<[TableViewCellType]> { return cell.asObservable() }
    private let cell = BehaviorRelay<[TableViewCellType]>(value: [])
    
    let loadInProgress = BehaviorRelay(value: false)
    let disposeBag = DisposeBag()
    
    func getAnalysisByTitle(_ title: String, ingr: [String]) {
        
        loadInProgress.accept(true)
        AnalysisServices().getAnalysisBy(title: title, ingr: ingr).subscribe(
            onNext: { [weak self] recipe in
                self?.loadInProgress.accept(false)
                guard let rec = recipe else {
                    self?.cell.accept([.empty])
                    return
                }
                let sumVM: SummaryViewCellModel = SummaryViewCellModel(calories: rec.calories?.description ?? "" ,
                                                                       diet: rec.dietLabels?.description ?? "",
                                                                       healthLabel: rec.healthLabels?.description ?? "")
                var dataBinding = [TableViewCellType]()
                dataBinding.append(TableViewCellType.normalSummaryCell(cellViewModel: sumVM))
                dataBinding.append(contentsOf: self?.getNutrientsFilterdData(rec.totalNutrients) ?? [])
                self?.cell.accept(dataBinding)
                return
            }, onError: { [weak self] error in
                self?.loadInProgress.accept(false)
                self?.cell.accept([.error(message: error.localizedDescription)])
            }
        ).disposed(by: disposeBag)
    }
    
    private func getNutrientsFilterdData(_ nutrients: [String: Nutrients]?) -> [TableViewCellType] {
        guard let nut = nutrients else { return [] }        
        var nutrientsDataFiltered =  [TableViewCellType]()
        nut.forEach({
            (key, value) in
            DataPresnet.allCases.forEach {
                if $0.rawValue == key {
                    nutrientsDataFiltered.append(TableViewCellType.normalNutrientsCell(cellViewModel: NutrientsCellViewModel(nutrient: value)))
                    return
                }
            }
        })
        return nutrientsDataFiltered
    }
    
}
