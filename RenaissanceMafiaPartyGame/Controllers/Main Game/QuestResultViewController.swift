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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questResultView = QuestResultView(frame: view.frame)
        view.addSubview(questResultView)
        
        var failureCount = 0
        for (_, decision) in roundInfo.playersQuestDecision {
            if decision == false {
                failureCount += 1
            }
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
        
    }
    
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
}
