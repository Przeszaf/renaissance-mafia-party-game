//
//  MissionAgreementView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MissionAgreementView: UIView {
    
    var askLabel = UILabel()
    var agreeButton = UIButton()
    var disagreeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(askLabel)
        addSubview(agreeButton)
        addSubview(disagreeButton)
        
        agreeButton.setTitle("Agree", for: .normal)
        agreeButton.backgroundColor = UIColor.blue
        disagreeButton.setTitle("Disagree", for: .normal)
        disagreeButton.backgroundColor = UIColor.red
        askLabel.font = UIFont.boldSystemFont(ofSize: 24)
        askLabel.text = "Do you agree?"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        disagreeButton.translatesAutoresizingMaskIntoConstraints = false
        
        askLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        askLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        agreeButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        disagreeButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        disagreeButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        agreeButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        
        agreeButton.widthAnchor.constraint(equalTo: disagreeButton.widthAnchor).isActive = true
        
        agreeButton.leadingAnchor.constraint(equalTo: disagreeButton.trailingAnchor, constant: 20).isActive = true
    }
    
    
}
