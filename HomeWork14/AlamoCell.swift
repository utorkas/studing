//
//  AlamoCell.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 26.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit

class AlamoCell: UITableViewCell {
    
    @IBOutlet weak var alamoTemp: UILabel!
    @IBOutlet weak var alamoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
