//
//  ShowInfoView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ShowPlayersClassView: UIView {
    
    var nameLabel = UILabel()
    var classLabel = UILabel()
    var visibilityLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let font = UIFont.boldSystemFont(ofSize: 24)
        addSubview(nameLabel)
        addSubview(classLabel)
        addSubview(visibilityLabel)
        nameLabel.font = font
        classLabel.font = font
        visibilityLabel.font = font
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        classLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        classLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        visibilityLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor).isActive = true
        visibilityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}
