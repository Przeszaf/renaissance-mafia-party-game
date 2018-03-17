//
//  MissionResultCell.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MissionResultCell: UITableViewCell {
    
    var playerNameLabel =  UILabel()
    var decisionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(decisionLabel)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerNameLabel.frame = CGRect(x: 10, y: 5, width: frame.width * 3 / 4, height: 30)
        decisionLabel.frame = CGRect(x: playerNameLabel.frame.width + 5, y: 5, width: frame.width * 1 / 4 - 5, height: 30)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
