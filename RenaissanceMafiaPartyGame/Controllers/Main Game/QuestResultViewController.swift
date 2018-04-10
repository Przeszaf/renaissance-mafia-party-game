//
//  QuestResultViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class QuestResultViewController: UIViewController {
    
    var questResultView: QuestResultView!
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    var swordUsedByPlayer: Player?
    var swordUsedOnPlayer: Player?
    var failureCount = 0
    var gradientLayer: CAGradientLayer!
    
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        questResultView = QuestResultView(frame: view.frame)
        view.addSubview(questResultView)
        
        for (_, decision) in roundInfo.playersQuestDecision {
            if decision == false {
                failureCount += 1
            }
        }
        
        if let usedBy = swordUsedByPlayer, let usedOn = swordUsedOnPlayer {
            questResultView.swordUsedLabel.text = "Sword of Distrust was used by \(usedBy) on \(usedOn)!"
        }
        
        if failureCount > 0 {
            questResultView.resultLabel.text = "Mission failed!"
            if failureCount == 1 {
                questResultView.failuresCountLabel.text = "\(failureCount) person wanted this mission to fail :(."
            } else {
                questResultView.failuresCountLabel.text = "\(failureCount) people voted for fail :(."
            }
            roundInfo.roundWin = false
        } else {
            questResultView.resultLabel.text = "Mission succeeded!"
            roundInfo.roundWin = true
        }
        gameInfo.nextLeader()
        configureGradient(colors: [UIColor(red: 0.5, green: 0, blue: 1, alpha: 1).cgColor, UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var toColors = [CGColor]()
        if failureCount == 0 {
            toColors = [UIColor.green.cgColor, UIColor(red: 0, green: 0.3, blue: 0.7, alpha: 0.9).cgColor]
        } else {
            toColors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        }
        
        //Gradient animation
        let gradientColorAnimation = CABasicAnimation(keyPath: "colors")
        gradientColorAnimation.toValue = toColors
        gradientColorAnimation.duration = 4.00
        gradientColorAnimation.isRemovedOnCompletion = false
        gradientColorAnimation.fillMode = kCAFillModeBoth
        gradientColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        gradientLayer.add(gradientColorAnimation, forKey: "animateGradient")
    }
    
    //MARK: - Touch ups
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainGameViewController") as! MainGameViewController
        mainVC.roundInfo = roundInfo
        mainVC.gameInfo = gameInfo
        if gameInfo.expansions.contains(where: {$0.name == "Magic Mirror"}) && gameInfo.rounds.count >= 2 {
            mainVC.useMagicMirror = true
        }
        show(mainVC, sender: self)
    }
    
    
    //MARK: - Other functions
    func configureGradient(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLocations: [NSNumber] = [0,1.0]
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        gradientLayer.frame = view.bounds
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        view.insertSubview(backgroundView, at: 0)
    }
    
    
}
