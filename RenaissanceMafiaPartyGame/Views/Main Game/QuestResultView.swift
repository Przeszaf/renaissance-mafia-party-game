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
    
    var swordUsedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(resultLabel)
        addSubview(failuresCountLabel)
        addSubview(swordUsedLabel)
        
        resultLabel.font = UIFont.boldSystemFont(ofSize: 24)
        resultLabel.textColor = UIColor.black
        failuresCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        failuresCountLabel.textColor = UIColor.red
        resultLabel.numberOfLines = 0
        failuresCountLabel.numberOfLines = 0
        swordUsedLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        failuresCountLabel.translatesAutoresizingMaskIntoConstraints = false
        swordUsedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        failuresCountLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor).isActive = true
        failuresCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        failuresCountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        failuresCountLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
        swordUsedLabel.topAnchor.constraint(equalTo: failuresCountLabel.bottomAnchor).isActive = true
        swordUsedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        swordUsedLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        swordUsedLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        
    }
    
}
