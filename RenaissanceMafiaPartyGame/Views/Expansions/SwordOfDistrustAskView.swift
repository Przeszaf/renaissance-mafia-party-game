//
//  SwordOfDistrustAskView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 29/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SwordOfDistrustAskView: UIView {
    
    var askLabel = UILabel()
    var yesButton = UIButton()
    var noButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(askLabel)
        addSubview(yesButton)
        addSubview(noButton)
        askLabel.numberOfLines = 0
        yesButton.backgroundColor = UIColor.green
        noButton.backgroundColor = UIColor.red
        yesButton.setTitle("YES", for: .normal)
        noButton.setTitle("NO", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.translatesAutoresizingMaskIntoConstraints = false
        
        askLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        askLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        askLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        askLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        yesButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        yesButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        noButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        noButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        yesButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        noButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
    }
}
