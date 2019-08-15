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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answerCell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        answerCell.lbAnswerItem.text = answerItemsArray[indexPath.row]
        return answerCell
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
