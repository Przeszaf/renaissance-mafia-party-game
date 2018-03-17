//
//  MainGameView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MainGameView: UIView {
    
    var label = UILabel()
    var button = UIButton(type: UIButtonType.system)
    var button2 = UIButton(type: .system)
    var gameBoardView: GameBoardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, fillColors: [UIColor]?) {
        self.init(frame: frame)
        gameBoardView = GameBoardView(frame: self.frame, fillColors: fillColors)
        addSubview(label)
        addSubview(button)
        addSubview(button2)
        addSubview(gameBoardView)
        label.text = "Main Game View"
        button.setTitle("Show classes to players", for: .normal)
        button2.setTitle("Select team", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        button2.topAnchor.constraint(equalTo: gameBoardView.bottomAnchor).isActive = true
        button2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        gameBoardView.topAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        gameBoardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gameBoardView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        gameBoardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        
        print(gameBoardView.frame)
    }
}
