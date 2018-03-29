//
//  MissionAgreementViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MissionAgreementViewController: UIViewController {
    
    var missionAgreementView: MissionAgreementView!
    var passPhoneView: PassPhoneView!
    
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    var selectedPlayers: [Player]!
    var currentPlayer: Player!
    var finishedAsking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = gameInfo.currentLeader
        missionAgreementView = MissionAgreementView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(missionAgreementView)
        missionAgreementView.teamLabel.text = "\(selectedPlayers.map({$0.name!}).joined(separator: ", "))"
        missionAgreementView.isHidden = true
        missionAgreementView.alpha = 0
        
        missionAgreementView.agreeButton.addTarget(self, action: #selector(agreeOrDisagreeButtonPressed(_:)), for: .touchUpInside)
        missionAgreementView.disagreeButton.addTarget(self, action: #selector(agreeOrDisagreeButtonPressed(_:)), for: .touchUpInside)
        
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
        case "showMissionResult"?:
            let controller = segue.destination as! MissionResultViewController
            controller.selectedPlayers = selectedPlayers
            controller.roundInfo = roundInfo
            controller.gameInfo = gameInfo
        default:
            preconditionFailure("Wronge segue identifier.")
        }
    }
    
    @objc func agreeOrDisagreeButtonPressed(_ sender: UIButton) {
        if sender == missionAgreementView.agreeButton {
            roundInfo.playersMissionDecision[currentPlayer] = true
        } else if sender == missionAgreementView.disagreeButton {
            roundInfo.playersMissionDecision[currentPlayer] = false
        }
        let index = gameInfo.players.index(of: currentPlayer)!
        if index + 1 < gameInfo.players.count {
            currentPlayer = gameInfo.players[index + 1]
        } else {
            currentPlayer = gameInfo.players[0]
        }
        if currentPlayer == gameInfo.currentLeader {
            finishedAsking = true
        }
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        passPhoneView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.missionAgreementView.alpha = 0
            self.missionAgreementView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.passPhoneView.alpha = 1
            self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.missionAgreementView.isHidden = true
        }
    }
    
    
    @objc func passPhoneViewPressed(recognizer: UITapGestureRecognizer) {
        if finishedAsking {
            performSegue(withIdentifier: "showMissionResult", sender: self)
            return
        }
        missionAgreementView.askLabel.text = "Do you accept this mission?"
        missionAgreementView.isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.passPhoneView.alpha = 0
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.missionAgreementView.alpha = 1
            self.missionAgreementView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.passPhoneView.isHidden = true
        }
    }
}
