//
//  SummaryTableViewCell.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 31/03/2021.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet private weak var totalCaloriesLabel: UILabel!
    @IBOutlet private weak var dietLabel: UILabel!
    @IBOutlet private weak var healthLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.totalCaloriesLabel.text = ""
        self.dietLabel.text = ""
        self.healthLabel.text = ""
    }
    
    var viewModel: SummaryViewCellModel? {
        didSet { bindViewModel() }
    }

    private func bindViewModel() {
        self.totalCaloriesLabel.text = viewModel?.totalCalories
        self.dietLabel.text = viewModel?.dietLabel
        self.healthLabel.text = viewModel?.healthLabel
    }
}
