//
//  HomeServices.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import Foundation
import SwiftyJSON
import RxSwift

class AnalysisServices {
    enum AnalysisFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }

    func getAnalysisBy(title: String, ingr: [String] ) -> Observable<Recipe?> {
        return Observable.create { observer -> Disposable in
            AFN.request(httpMethod: .post, paramter: ["title":title, "ingr":ingr]) { (response, statucCode, error) in
                let responseJson = JSON(response ?? "")
                if let recipe = CodableHandler.decodeClass(Recipe.self, classJsonData: responseJson) as? Recipe {
                    observer.onNext(recipe)
                    return
                }
                if let err = error {
                    observer.onError(err)
                }
                
            }
            return Disposables.create()
        }
       
    }
}
