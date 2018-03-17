//
//  SelectPlayersCell.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SelectPlayersCell: UITableViewCell {
    
    var playerPosition = UILabel()
    var playerName =  UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerName)
        contentView.addSubview(playerPosition)
        
        playerPosition.font = UIFont.systemFont(ofSize: 17)
        playerName.font = UIFont.systemFont(ofSize: 17)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerPosition.frame = CGRect(x: 10, y: 2, width: 40, height: 30)
        playerName.frame = CGRect(x: 40, y: 2, width: frame.width - 50, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
