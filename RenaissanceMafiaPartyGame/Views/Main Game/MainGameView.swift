//
//  MainGameView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MainGameView: UIView {
    
    var leaderLabel = UILabel()
    var missionFailedLabel = UILabel()
    var magicMirrorLabel = UILabel()
    var nextButton = UIButton(type: UIButtonType.roundedRect)
    var gameBoardView: GameBoardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, fillColors: [UIColor]?) {
        self.init(frame: frame)
        gameBoardView = GameBoardView(frame: self.frame, fillColors: fillColors)
        addSubview(leaderLabel)
        addSubview(missionFailedLabel)
        addSubview(magicMirrorLabel)
        addSubview(nextButton)
        addSubview(nextButton)
        addSubview(gameBoardView)
        leaderLabel.text = "Main Game View"
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leaderLabel.translatesAutoresizingMaskIntoConstraints = false
        missionFailedLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        magicMirrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leaderLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        leaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        missionFailedLabel.topAnchor.constraint(equalTo: leaderLabel.bottomAnchor).isActive = true
        missionFailedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        magicMirrorLabel.topAnchor.constraint(equalTo: missionFailedLabel.bottomAnchor).isActive = true
        magicMirrorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        gameBoardView.topAnchor.constraint(equalTo: magicMirrorLabel.bottomAnchor).isActive = true
        gameBoardView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gameBoardView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        gameBoardView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
