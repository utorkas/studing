//
//  TableViewCell.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 20.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameTask: UILabel!
    @IBOutlet weak var nameTaskCoreData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
