//
//  MainGameView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MainGameView: UIView {
    
    var label = UILabel()
    var button = UIButton(type: UIButtonType.system)
    var button2 = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(button)
        addSubview(button2)
        label.text = "Main Game View"
        button.setTitle("Show info to players", for: .normal)
        button2.setTitle("Does nothing yet", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        button2.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        button2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
