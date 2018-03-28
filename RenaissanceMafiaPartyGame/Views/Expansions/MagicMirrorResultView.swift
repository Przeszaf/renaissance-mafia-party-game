//
//  MagicMirrorResultView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 28/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MagicMirrorResultView: UIView {
    
    var fractionImage = UIImageView()
    var classLabel = UILabel()
    var remainderLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        classLabel.numberOfLines = 0
        remainderLabel.numberOfLines = 0
        addSubview(fractionImage)
        addSubview(classLabel)
        addSubview(remainderLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fractionImage.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        remainderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fractionImage.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        fractionImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fractionImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        fractionImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        classLabel.topAnchor.constraint(equalTo: fractionImage.bottomAnchor).isActive = true
        classLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        remainderLabel.topAnchor.constraint(equalTo: classLabel.bottomAnchor).isActive = true
        remainderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        remainderLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 60).isActive = true
    }
}
