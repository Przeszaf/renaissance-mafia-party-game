//
//  QuestResultViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class QuestResultViewController: UIViewController {
    
    var playersDecision: [Player: Bool]!
    var questResultView: QuestResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questResultView = QuestResultView(frame: view.frame)
        view.addSubview(questResultView)
        
        var failureCount = 0
        for (_, decision) in playersDecision {
            if decision == false {
                failureCount += 1
            }
        }
        
        if failureCount > 0 {
            questResultView.resultLabel.text = "Mission failed!"
        } else {
            questResultView.resultLabel.text = "Mission succeeded!"
        }
    }
}
