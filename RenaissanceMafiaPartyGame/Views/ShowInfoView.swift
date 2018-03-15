//
//  ShowInfoView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ShowInfoView: UIView {
    
    var label = UILabel()
    var label2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(label2)
        label.text = "Show Info View"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        label2.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
}
