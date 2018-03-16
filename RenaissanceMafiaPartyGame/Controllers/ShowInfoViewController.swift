//
//  ShowInfoViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ShowInfoViewController: UIViewController {
    
    var showPlayersClassView: ShowPlayersClassView!
    var passPhoneView: PassPhoneView!
    
    
    var currentPlayer: Player!
    var players: [Player]!
    var playersClasses: [Player: GameClasses]!
    var visibility: [Player: [Player]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = players.first!
        
        showPlayersClassView = ShowPlayersClassView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(showPlayersClassView)
        showPlayersClassView.isHidden = true
        showPlayersClassView.alpha = 0
        
        passPhoneView = PassPhoneView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(passPhoneView)
        passPhoneView.isHidden = false
        passPhoneView.alpha = 1
        
        let tapShowPlayersClassView = UITapGestureRecognizer(target: self, action: #selector(tappedOnShowPlayersClassView(recognizer:)))
        let tapPassPhoneView = UITapGestureRecognizer(target: self, action: #selector(tappedOnPassPhoneView(recognizer:)))
        
        showPlayersClassView.addGestureRecognizer(tapShowPlayersClassView)
        passPhoneView.addGestureRecognizer(tapPassPhoneView)
        
        showPlayersClassView.nameLabel.numberOfLines = 0
        showPlayersClassView.classLabel.numberOfLines = 0
        showPlayersClassView.visibilityLabel.numberOfLines = 0
        
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name)"
    }
    
    @objc func tappedOnShowPlayersClassView(recognizer: UITapGestureRecognizer) {
        if recognizer.view == showPlayersClassView {
            guard let index = players.index(of: currentPlayer) else { return }
            if index + 1 < players.count {
                currentPlayer = players[index + 1]
            } else {
                navigationController?.popViewController(animated: true)
            }
            self.passPhoneView.nameLabel.text = "Pass phone to \(self.currentPlayer.name)"
            self.passPhoneView.isHidden = false
            UIView.animate(withDuration: 1, animations: {
                self.passPhoneView.alpha = 1
                self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.showPlayersClassView.alpha = 0
                self.showPlayersClassView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (finished) in
                self.showPlayersClassView.isHidden = true
            })
        }
    }
    
    
    @objc func tappedOnPassPhoneView(recognizer: UITapGestureRecognizer) {
        self.showPlayersClassView.isHidden = false
        self.showPlayersClassView.nameLabel.text = "Hello \(currentPlayer.name)!"
        self.showPlayersClassView.classLabel.text = "You are \(self.playersClasses[self.currentPlayer]?.rawValue ?? "ERROR")"
        var string = [String]()
        if let visiblePlayers = self.visibility[self.currentPlayer] {
            for visiblePlayer in visiblePlayers {
                string.append(visiblePlayer.name)
            }
        }
        if !string.isEmpty {
            self.showPlayersClassView.visibilityLabel.text = "You are in same team with \(string.joined(separator: ", "))."
        } else {
            self.showPlayersClassView.visibilityLabel.text = ""
        }
        UIView.animate(withDuration: 1, animations: {
            self.passPhoneView.alpha = 0
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.showPlayersClassView.alpha = 1
            self.showPlayersClassView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: { (finished) in
            self.passPhoneView.isHidden = true
        })
    }
}
