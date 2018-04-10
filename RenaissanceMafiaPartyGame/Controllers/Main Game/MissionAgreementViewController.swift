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
    var passPhoneGradient = CAGradientLayer()
    var missionAgreementGradient = CAGradientLayer()
    
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    var selectedPlayers: [Player]!
    var currentPlayer: Player!
    var finishedAsking = false
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = gameInfo.currentLeader
        
        //Create views
        missionAgreementView = MissionAgreementView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(missionAgreementView)
        missionAgreementView.teamLabel.text = "\(selectedPlayers.map({$0.name!}).joined(separator: ", "))"
        missionAgreementView.isHidden = true
        
        missionAgreementView.agreeButton.addTarget(self, action: #selector(agreeOrDisagreeButtonPressed(_:)), for: .touchUpInside)
        missionAgreementView.disagreeButton.addTarget(self, action: #selector(agreeOrDisagreeButtonPressed(_:)), for: .touchUpInside)
        
        passPhoneView = PassPhoneView(frame: view.frame)
        passPhoneView.isHidden = false
        view.addSubview(passPhoneView)
        
        
        //Create gradient with random colors for first view
        configureGradient(for: passPhoneView, colors: [randomColor(), randomColor()], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(passPhoneViewPressed(recognizer:)))
        passPhoneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Segues
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
    
    //MARK: - Buttons and touches
    
    @objc func agreeOrDisagreeButtonPressed(_ sender: UIButton) {
        //Update the dictionary of decisions
        if sender == missionAgreementView.agreeButton {
            roundInfo.playersMissionDecision[currentPlayer] = true
        } else if sender == missionAgreementView.disagreeButton {
            roundInfo.playersMissionDecision[currentPlayer] = false
        }
        let index = gameInfo.players.index(of: currentPlayer)!
        //Set next player
        if index + 1 < gameInfo.players.count {
            currentPlayer = gameInfo.players[index + 1]
        } else {
            currentPlayer = gameInfo.players[0]
        }
        //If it came back to leader, then finish asking for decisions
        if currentPlayer == gameInfo.currentLeader {
            finishedAsking = true
        }
        passPhoneView.nameLabel.text = "Pass phone to \(currentPlayer.name!)"
        passPhoneView.isHidden = false
        
        //Create gradient
        let leftColor = missionAgreementGradient.colors?.last as! CGColor
        let rightColor = randomColor()
        configureGradient(for: passPhoneView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        
        //Right to left animation
        UIView.animate(withDuration: 1, animations: {
            self.missionAgreementView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.missionAgreementView.isHidden = true
            self.missionAgreementView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    
    @objc func passPhoneViewPressed(recognizer: UITapGestureRecognizer) {
        if finishedAsking {
            performSegue(withIdentifier: "showMissionResult", sender: self)
            return
        }
        
        missionAgreementView.askLabel.text = "Do you accept this mission?"
        missionAgreementView.isHidden = false
        
        //Create gradient
        let leftColor = passPhoneGradient.colors?.last as! CGColor
        let rightColor = randomColor()
        configureGradient(for: missionAgreementView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        
        //Right to left animation
        UIView.animate(withDuration: 1, animations: {
            self.passPhoneView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.missionAgreementView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (completed) in
            self.passPhoneView.isHidden = true
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    //MARK: - Other functions
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
        } else if view == missionAgreementView {
            missionAgreementGradient.removeFromSuperlayer()
            missionAgreementGradient = CAGradientLayer()
            missionAgreementGradient.colors = colors
            missionAgreementGradient.locations = gradientLocations
            missionAgreementGradient.startPoint = startPoint
            missionAgreementGradient.endPoint = endPoint
            missionAgreementGradient.frame = view.bounds
            view.layer.insertSublayer(missionAgreementGradient, at: 0)
        }
    }
    
    func randomColor() -> CGColor {
        let randomColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: CGFloat(arc4random_uniform(255)) / 255.0)
        return randomColor.cgColor
    }
    
}
