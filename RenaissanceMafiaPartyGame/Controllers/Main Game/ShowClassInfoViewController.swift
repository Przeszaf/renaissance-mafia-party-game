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
    var middleColor: CGColor!
    var passPhoneGradient = CAGradientLayer()
    var showPlayersGradient = CAGradientLayer()
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = gameInfo.currentLeader
        
        //Setting up views
        showPlayersClassView = ShowPlayersClassView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(showPlayersClassView)
        showPlayersClassView.isHidden = true
        showPlayersClassView.alpha = 1
        
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
        
        //Add random color gradient to first view seen
        configureGradient(for: passPhoneView, colors: [randomColor(), randomColor()], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
    }
    
    //MARK: - Buttons
    
    @objc func tappedOnShowPlayersClassView(recognizer: UITapGestureRecognizer) {
        if recognizer.view == showPlayersClassView {
            guard let index = gameInfo.players.index(of: currentPlayer) else { return }
            //Change currentPlayer to next player
            if index + 1 < gameInfo.players.count {
                currentPlayer = gameInfo.players[index + 1]
            } else {
                currentPlayer = gameInfo.players[0]
            }
            //If currentPlayer is currentLeader, then finish showing classes
            if currentPlayer == gameInfo.currentLeader {
                doneShowing = true
            }
            self.passPhoneView.nameLabel.text = "Pass phone to \(self.currentPlayer.name!)"
            self.passPhoneView.isHidden = false
            
            //Configure gradient for new view
            let leftColor = showPlayersGradient.colors?.last as! CGColor
            let rightColor = randomColor()
            configureGradient(for: passPhoneView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
            
            //From right to left animation transition
            UIView.animate(withDuration: 1, animations: {
                self.passPhoneView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.showPlayersClassView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (finished) in
                //Shift the other view to right after finishing, so it can appear from right to left again
                self.showPlayersClassView.isHidden = true
                self.showPlayersClassView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            })
        }
    }
    
    
    @objc func tappedOnPassPhoneView(recognizer: UITapGestureRecognizer) {
        if doneShowing {
            performSegue(withIdentifier: "startGame", sender: self)
        }
        self.showPlayersClassView.isHidden = false
        
        //Create Gradient for view at right
        let leftColor = passPhoneGradient.colors?.last as! CGColor
        let rightColor = randomColor()
        configureGradient(for: showPlayersClassView, colors: [leftColor, rightColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        self.showPlayersClassView.nameLabel.text = "Hello \(currentPlayer.name!)!"
        self.showPlayersClassView.classLabel.text = "You are \(self.gameInfo.playersClasses[self.currentPlayer]?.name! ?? "ERROR")"
        //Create correct string for players
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
        
        //Animation -> right to left
        UIView.animate(withDuration: 1, animations: {
            self.passPhoneView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.showPlayersClassView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: { (finished) in
            self.passPhoneView.isHidden = true
            self.passPhoneView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        })
    }
    
    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            let controller = segue.destination as! MainGameViewController
            controller.gameInfo = gameInfo
            controller.createNewRound()
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
        } else if view == showPlayersClassView {
            showPlayersGradient.removeFromSuperlayer()
            showPlayersGradient = CAGradientLayer()
            showPlayersGradient.colors = colors
            showPlayersGradient.locations = gradientLocations
            showPlayersGradient.startPoint = startPoint
            showPlayersGradient.endPoint = endPoint
            showPlayersGradient.frame = view.bounds
            view.layer.insertSublayer(showPlayersGradient, at: 0)
        }
    }
    
    func randomColor() -> CGColor {
        let randomColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: CGFloat(arc4random_uniform(255)) / 255.0)
        return randomColor.cgColor
    }
    
}
