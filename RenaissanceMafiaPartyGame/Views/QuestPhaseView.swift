//
//  QuestPhaseView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class QuestPhaseView: UIView {
    
    var askLabel = UILabel()
    var successButton = UIButton()
    var failButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(askLabel)
        addSubview(successButton)
        addSubview(failButton)
        
        successButton.setTitle("Success!", for: .normal)
        successButton.backgroundColor = UIColor.blue
        failButton.setTitle("Fail!", for: .normal)
        failButton.backgroundColor = UIColor.red
        askLabel.font = UIFont.boldSystemFont(ofSize: 24)
        askLabel.text = "Do you want this mission to succeed?"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        successButton.translatesAutoresizingMaskIntoConstraints = false
        failButton.translatesAutoresizingMaskIntoConstraints = false
        
        askLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        askLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        successButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        failButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        failButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        successButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        
        successButton.widthAnchor.constraint(equalTo: failButton.widthAnchor).isActive = true
        
        successButton.leadingAnchor.constraint(equalTo: failButton.trailingAnchor, constant: 20).isActive = true
    }
}
