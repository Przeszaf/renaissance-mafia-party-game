//
//  ShowInfoViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ShowClassInfoViewController: UIViewController {
    
    var showPlayersClassView: ShowPlayersClassView!
    var passPhoneView: PassPhoneView!
    
    var gameInfo: GameInfo!
    var currentPlayer: Player!
    var doneShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = gameInfo.currentLeader
        
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
        
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        
    }
    
    @objc func tappedOnShowPlayersClassView(recognizer: UITapGestureRecognizer) {
        if recognizer.view == showPlayersClassView {
            guard let index = gameInfo.players.index(of: currentPlayer) else { return }
            if index + 1 < gameInfo.players.count {
                currentPlayer = gameInfo.players[index + 1]
            } else {
                currentPlayer = gameInfo.players[0]
            }
            if currentPlayer == gameInfo.currentLeader {
                doneShowing = true
            }
            self.passPhoneView.nameLabel.text = "Pass phone to \(self.currentPlayer.name!)"
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
        performSegue(withIdentifier: "startGame", sender: self)
        if doneShowing {
            performSegue(withIdentifier: "startGame", sender: self)
        }
        self.showPlayersClassView.isHidden = false
        self.showPlayersClassView.nameLabel.text = "Hello \(currentPlayer.name!)!"
        self.showPlayersClassView.classLabel.text = "You are \(self.gameInfo.playersClasses[self.currentPlayer]?.name! ?? "ERROR")"
        var string = [String]()
        if let visiblePlayers = self.gameInfo.visibility[self.currentPlayer] {
            for visiblePlayer in visiblePlayers {
                string.append(visiblePlayer.name!)
            }
        }
        if !string.isEmpty {
            if gameInfo.playersClasses[currentPlayer]?.name! == "Psychic" {
                self.showPlayersClassView.visibilityLabel.text = "You feel that \(string.joined(separator: ", ")) have magic powers."
            } else {
                self.showPlayersClassView.visibilityLabel.text = "You are in same team with \(string.joined(separator: ", "))."
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            let controller = segue.destination as! MainGameViewController
            controller.gameInfo = gameInfo
            controller.createNewRound()
        }
    }
}
