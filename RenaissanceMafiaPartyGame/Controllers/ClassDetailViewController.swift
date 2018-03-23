//
//  ClassDetailViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        view.addSubview(label)
        label.text = "AAAAA"
        label.backgroundColor = UIColor.red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
}
