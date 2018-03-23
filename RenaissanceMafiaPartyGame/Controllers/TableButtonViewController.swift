//
//  TableButtonViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class TableButtonViewController: UIViewController {
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.backgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 0.4)
        view.addSubview(button)
    }
}
