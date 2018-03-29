//
//  MissionAgreedViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class QuestPhaseViewController: UIViewController {
    
    var questPhaseView: QuestPhaseView!
    var passPhoneView: PassPhoneView!
    
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    var selectedPlayers: [Player]!
    var currentPlayer: Player!
    var finishedAsking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = selectedPlayers[0]
        questPhaseView = QuestPhaseView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(questPhaseView)
        questPhaseView.isHidden = true
        questPhaseView.alpha = 0
        
        questPhaseView.successButton.addTarget(self, action: #selector(successOrFailButtonPressed(_:)), for: .touchUpInside)
        questPhaseView.failButton.addTarget(self, action: #selector(successOrFailButtonPressed(_:)), for: .touchUpInside)
        
        passPhoneView = PassPhoneView(frame: view.frame)
        passPhoneView.isHidden = false
        passPhoneView.alpha = 1
        view.addSubview(passPhoneView)
        
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(passPhoneViewPressed(recognizer:)))
        passPhoneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showQuestResult"?:
            let controller = segue.destination as! QuestResultViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
        case "swordOfDistrustGive"?:
            let controller = segue.destination as! SwordOfDistrustGiveViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.selectedPlayers = selectedPlayers
        default:
            preconditionFailure("Wronge segue identifier.")
        }
    }
    
    @objc func successOrFailButtonPressed(_ sender: UIButton) {
        if sender == questPhaseView.successButton {
            roundInfo.playersQuestDecision[currentPlayer] = true
        } else if sender == questPhaseView.failButton {
            let playerClass = gameInfo.playersClasses[currentPlayer]!
            if playerClass.isGood {
                return
            }
            roundInfo.playersQuestDecision[currentPlayer] = false
        }
        let index = selectedPlayers.index(of: currentPlayer)!
        if index + 1 < selectedPlayers.count {
            currentPlayer = selectedPlayers[index + 1]
        } else {
            currentPlayer = selectedPlayers[0]
            finishedAsking = true
        }
        if finishedAsking {
            passPhoneView.nameLabel.text = "Pass phone to \(gameInfo.currentLeader.name!)"
        } else {
            passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        }
        passPhoneView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.questPhaseView.alpha = 0
            self.questPhaseView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.passPhoneView.alpha = 1
            self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.questPhaseView.isHidden = true
        }
    }
    
    @objc func passPhoneViewPressed(recognizer: UITapGestureRecognizer) {
        if finishedAsking == true {
            if gameInfo.expansions.contains(where: {$0.name == "Sword of Distrust"}) {
                performSegue(withIdentifier: "swordOfDistrustGive", sender: self)
            } else {
                performSegue(withIdentifier: "showQuestResult", sender: self)
            }
            return
        }
        questPhaseView.askLabel.text =  "Do you want this mission to succeed?"
        questPhaseView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.passPhoneView.alpha = 0
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.questPhaseView.alpha = 1
            self.questPhaseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.passPhoneView.isHidden = true
        }
    }
}
