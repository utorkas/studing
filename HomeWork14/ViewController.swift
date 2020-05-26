//
//  ViewController.swift
//  HomeWork14
//
//  Created by Сергей Кузнецов on 13.05.2020.
//  Copyright © 2020 Сергей Кузнецов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBAction func nameTextField(_ sender: Any) {
    
        let nameTrimmingText = name.text!.trimmingCharacters(in: .whitespaces)
        Persistance.shared.userName = nameTrimmingText
        print(nameTrimmingText)
    }
    @IBAction func surnameTextField(_ sender: Any) {
        let nameTrimmingText = surname.text!.trimmingCharacters(in: .whitespaces)
        Persistance.shared.userSurname = nameTrimmingText
        print(nameTrimmingText)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = Persistance.shared.userName
        surname.text = Persistance.shared.userSurname
        print(Persistance.shared.userName as Any)
        print(Persistance.shared.userSurname as Any)
    }
}


