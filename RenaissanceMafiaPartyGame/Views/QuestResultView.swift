//
//  QuestResultView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class QuestResultView: UIView {
    
    var resultLabel = UILabel()
    var failuresCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(resultLabel)
        addSubview(failuresCountLabel)
        
        resultLabel.font = UIFont.boldSystemFont(ofSize: 24)
        resultLabel.textColor = UIColor.black
        failuresCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        failuresCountLabel.textColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        failuresCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        failuresCountLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor).isActive = true
        failuresCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
}
