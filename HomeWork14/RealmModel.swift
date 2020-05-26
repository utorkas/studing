//
//  RealmModel.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 24.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import Foundation
import RealmSwift

class Tasks: Object {
    @objc dynamic var name = ""
    @objc dynamic var isDone: Bool = false
}
