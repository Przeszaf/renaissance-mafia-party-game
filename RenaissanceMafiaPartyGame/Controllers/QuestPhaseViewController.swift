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
    
    var currentPlayer: Player!
    var selectedPlayers: [Player]!
    var playersClasses: [Player: GameClass]!
    var playersDecision = [Player: Bool]()
    var finishedAsking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = selectedPlayers[0]
        
        print(selectedPlayers)
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
            controller.playersDecision = playersDecision
        default:
            preconditionFailure("Wronge segue identifier.")
        }
    }
    
    @objc func successOrFailButtonPressed(_ sender: UIButton) {
        if sender == questPhaseView.successButton {
            playersDecision[currentPlayer] = true
        } else if sender == questPhaseView.failButton {
            playersDecision[currentPlayer] = false
        }
        let index = selectedPlayers.index(of: currentPlayer)!
        if index + 1 < selectedPlayers.count {
            currentPlayer = selectedPlayers[index + 1]
        } else {
            currentPlayer = selectedPlayers[0]
            finishedAsking = true
        }
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
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
            performSegue(withIdentifier: "showQuestResult", sender: self)
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
