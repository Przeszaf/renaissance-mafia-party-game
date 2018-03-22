//
//  GameClassCell.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class GameClassCell: UITableViewCell {
    
    var photo = UIImageView()
    var nameLabel =  UILabel()
    var descriptionLabel = UILabel()
    var countTextField = UITextField()
    var infoButton = UIButton(type: UIButtonType.infoLight)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        countTextField.borderStyle = .roundedRect
        
        addSubview(photo)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(infoButton)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photo.frame = CGRect(x: 5, y: 5, width: 150, height: 150)
        nameLabel.frame = CGRect(x: 165, y: 15, width: frame.width - 195, height: 20)
        descriptionLabel.frame = CGRect(x: 165, y: 40, width: frame.width - 195, height: 140)
        descriptionLabel.numberOfLines = 0
        infoButton.frame = CGRect(x: frame.width - 30, y: 10, width: 20, height: 20)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
