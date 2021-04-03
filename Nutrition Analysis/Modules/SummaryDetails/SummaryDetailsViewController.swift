//
//  SummaryDetailsViewController.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SummaryDetailsViewController: UIViewController {

    @IBOutlet private weak var summaryTableView: UITableView!
    private let disposeBag = DisposeBag()
    let viewModel = SummaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.viewModel.loadInProgress.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        let summaryNib = UINib(nibName: "SummaryTableViewCell", bundle: nil)
        let nutrientNib = UINib(nibName: "NutrientsTableViewCell", bundle: nil)
        self.summaryTableView.register(summaryNib, forCellReuseIdentifier: String(describing: SummaryTableViewCell.self))
        self.summaryTableView.register(nutrientNib, forCellReuseIdentifier: String(describing: NutrientsTableViewCell.self))
        self.viewModel.nutrientsCells.bind(to: self.summaryTableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normalSummaryCell(cellViewModel: let cellViewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as? SummaryTableViewCell
                cell?.viewModel = cellViewModel
                return cell ?? UITableViewCell()
            case .normalNutrientsCell(cellViewModel: let viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientsTableViewCell", for: indexPath) as? NutrientsTableViewCell
                cell?.viewModel = viewModel
                return cell ?? UITableViewCell()
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "No data available"
                return cell
            case .error(message: let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                return cell
            }
        }.disposed(by: disposeBag)
        
    }
}
