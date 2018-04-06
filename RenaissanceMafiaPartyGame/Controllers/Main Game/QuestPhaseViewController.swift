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
    var passPhoneGradient = CAGradientLayer()
    var questPhaseGradient = CAGradientLayer()
    
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
        
        questPhaseView.successButton.addTarget(self, action: #selector(successOrFailButtonPressed(_:)), for: .touchUpInside)
        questPhaseView.failButton.addTarget(self, action: #selector(successOrFailButtonPressed(_:)), for: .touchUpInside)
        
        passPhoneView = PassPhoneView(frame: view.frame)
        passPhoneView.isHidden = false
        view.addSubview(passPhoneView)
        
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        configureGradient(for: passPhoneView, colors: [randomColor(), randomColor()], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        
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
        let leftColor = questPhaseGradient.colors?.last as! CGColor
        let rightColor = randomColor()
        configureGradient(for: passPhoneView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        UIView.animate(withDuration: 0.1, animations: {
            self.questPhaseView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.questPhaseView.isHidden = true
            self.questPhaseView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
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
        let leftColor = passPhoneGradient.colors?.last as! CGColor
        let rightColor = randomColor()
        configureGradient(for: questPhaseView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        UIView.animate(withDuration: 0.1, animations: {
            self.passPhoneView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.questPhaseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.passPhoneView.isHidden = true
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func configureGradient(for view: UIView, colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        if view == passPhoneView {
            passPhoneGradient.removeFromSuperlayer()
            passPhoneGradient = CAGradientLayer()
            passPhoneGradient.colors = colors
            passPhoneGradient.locations = gradientLocations
            passPhoneGradient.startPoint = startPoint
            passPhoneGradient.endPoint = endPoint
            passPhoneGradient.frame = view.bounds
            view.layer.insertSublayer(passPhoneGradient, at: 0)
        } else if view == questPhaseView {
            questPhaseGradient.removeFromSuperlayer()
            questPhaseGradient = CAGradientLayer()
            questPhaseGradient.colors = colors
            questPhaseGradient.locations = gradientLocations
            questPhaseGradient.startPoint = startPoint
            questPhaseGradient.endPoint = endPoint
            questPhaseGradient.frame = view.bounds
            view.layer.insertSublayer(questPhaseGradient, at: 0)
        }
    }
    
    func randomColor() -> CGColor {
        let randomColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: CGFloat(arc4random_uniform(255)) / 255.0)
        return randomColor.cgColor
    }
    
}
