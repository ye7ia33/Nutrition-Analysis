//
//  HomeViewModel.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 30/03/2021.
//

import Foundation
import RxSwift
import RxCocoa
protocol HomeViewModelProtocol {
    var title: BehaviorRelay<String> { get }
    var ingredients: BehaviorRelay<String> { get }
//    var submitButtonEnabled: Observable<Bool> { get }
//    var submitButtonTapped: PublishSubject<Void> { get }

}
final class HomeViewModel: HomeViewModelProtocol {
    var title: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var ingredients: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
//    var submitButtonTapped: PublishSubject<Void> = PublishSubject<Void>()
}
