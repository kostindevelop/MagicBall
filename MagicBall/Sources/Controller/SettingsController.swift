//
//  SettingsController.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 13.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var answerItemsArray = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
    }
    
    private func configuredUI() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(openAddItemConroller))
    }
    
    @objc private func openAddItemConroller() {
        let alertController = UIAlertController(title: "Add new answer!", message: "Add new answer!", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { textField in
            textField.placeholder = "new answer"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            print("New answer \(String(describing: textField.text))")
            if let text = textField.text {
                self.answerItemsArray.append(text)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Enable/Disable personal answer"
        case 1: return "Answer options"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let myLabel = UILabel()
            myLabel.frame = CGRect(x: 24, y: 0, width: self.view.frame.width, height: 30)
            myLabel.font = UIFont.boldSystemFont(ofSize: 12)
            myLabel.textColor = .gray
            myLabel.text = "When turned on, personal answers will be used"
            let headerView = UIView()
            headerView.addSubview(myLabel)
            return headerView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return answerItemsArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let answerEnableCell = tableView.dequeueReusableCell(withIdentifier: "AnswerEnableCell", for: indexPath) as! AnswerEnableCell
            answerEnableCell.delegate = self
            answerEnableCell.switcherLocalAnswer.isOn = UserDefault.shared.localAnswerIsEnable()
            return answerEnableCell
        case 1:
            let answerCell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
            let localAnswerSwitcher = UserDefault.shared.localAnswerIsEnable()
            navigationItem.rightBarButtonItem?.isEnabled = localAnswerSwitcher
            answerCell.enable(on: localAnswerSwitcher)
            answerCell.lbAnswerItem.text = answerItemsArray[indexPath.row]
            return answerCell
        default:
            return UITableViewCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            self.answerItemsArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
}


// MARK: - SwitcherLocalAnswerProtocol

extension SettingsController: SwitcherLocalAnswerProtocol {
    func didTapEnabledLocalAnswerSwitcher() {
        tableView.reloadData()
    }
}
