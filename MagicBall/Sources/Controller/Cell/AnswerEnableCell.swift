//
//  AnswerEnableCell.swift
//  MagicBall
//
//  Created by Konstantin Igorevich on 16.08.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

protocol SwitcherLocalAnswerProtocol {
    func didTapEnabledLocalAnswerSwitcher()
}

class AnswerEnableCell: UITableViewCell {

    @IBOutlet weak var switcherLocalAnswer: UISwitch!
    
    var delegate: SwitcherLocalAnswerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didTapEnabledLocalAnswerSwitcher(_ sender: UISwitch) {
        UserDefault.shared.localAnswerIsEnable(switcher: sender.isOn)
        delegate?.didTapEnabledLocalAnswerSwitcher()
    }
    
}
