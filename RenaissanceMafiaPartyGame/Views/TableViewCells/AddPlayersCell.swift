//
//  AddPlayersCell.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

//Cell that is used when adding player
class AddPlayersCell: UITableViewCell {
    
    var playerName =  UITextField()
    var addButton = UIButton(type: UIButtonType.contactAdd)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerName)
        contentView.addSubview(addButton)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerName.frame = CGRect(x: 20, y: 5, width: frame.width * 3 / 4, height: 30)
        addButton.frame = CGRect(x: playerName.frame.width + 5, y: 5, width: frame.width * 1 / 4 - 5, height: 30)
        playerName.keyboardType = UIKeyboardType.alphabet
        playerName.placeholder = "Your name"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

