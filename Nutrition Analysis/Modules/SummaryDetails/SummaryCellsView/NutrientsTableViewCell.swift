//
//  NutrientsTableViewCell.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import UIKit

class NutrientsTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = "...."
        }
    }
    @IBOutlet private weak var quantityLabel: UILabel! {
        didSet {
            self.quantityLabel.text = "0.0"
        }
    }
    var viewModel: NutrientsCellViewModel? {
        didSet { bindViewModel() }
    }

    private func bindViewModel() {
        self.titleLabel.text = viewModel?.title
        self.quantityLabel.text = (viewModel?.quantity ?? "") + " / " + (viewModel?.unit ?? "")
    }
}
