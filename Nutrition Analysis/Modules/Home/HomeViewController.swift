//
//  HomeViewController.swift
//  Nutrition Analysis
//
//  Created by Yahia El-Dow on 30/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            self.titleTextField.text = ""
            self.titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var ingrTextView: UITextView! {
        didSet {
            self.ingrTextView.text = ""
        }
    }
    @IBOutlet weak var analysisButton: UIButton! {
        didSet {
            self.setButtonStyle(isEnabled: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSummeryDetails",
            let vc = segue.destination as? SummaryDetailsViewController {
            let title = self.titleTextField.text ?? ""
            let ingr = self.ingrTextView.text.components(separatedBy: "\n").filter { $0 != "" }
            vc.viewModel = SummaryViewModel(title, ingr: ingr)
            return
        }
    }
    
    @IBAction func analysisButtonAction(_ sender: Any) {
        if isValidForm() {
            self.performSegue(withIdentifier: "goToSummeryDetails", sender: nil)
        }
    }

    private func setButtonStyle(isEnabled: Bool) {
        self.analysisButton.isEnabled = isEnabled
        self.analysisButton.backgroundColor = isEnabled ? #colorLiteral(red: 0.6, green: 0.7333333333, blue: 0.6784313725, alpha: 1) : #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 0.8470588235)
    }
    
    private func isValidForm() -> Bool {
        guard let title = self.titleTextField.text, let ingrText = self.ingrTextView.text else { return false }
        return (title.count > 3) && ingrText.count > 3 //.contains("\n")
    }
}

extension HomeViewController: UITextViewDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.setButtonStyle(isEnabled: self.isValidForm())
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.setButtonStyle(isEnabled: self.isValidForm())
    }
}
