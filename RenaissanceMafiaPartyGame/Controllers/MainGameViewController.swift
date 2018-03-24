//
//  MainGameViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    var mainGameView: MainGameView!
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if roundInfo.roundWin != nil {
            createNewRound()
        }
        
        var roundsWon = 0
        var roundsLost = 0
        var fillColors = [UIColor]()
        for round in gameInfo.rounds {
            if round.roundWin == true {
                fillColors.append(UIColor.blue)
                roundsWon += 1
            } else if round.roundWin == false {
                fillColors.append(UIColor.red)
                roundsLost += 1
            }
        }
        mainGameView = MainGameView(frame: view.frame, fillColors: fillColors)
        view.addSubview(mainGameView)
        mainGameView.nextButton.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        mainGameView.missionFailedLabel.text = "Missions failed: \(roundInfo.failedMissionsCount)/5"
        mainGameView.leaderLabel.text = "Current leader is \(gameInfo.currentLeader.name!)"
        
        for (i, label) in mainGameView.gameBoardView.labels.enumerated() {
            label.text = "\(gameInfo.playersInTeam[i]) Players\n\(gameInfo.failuresToLose[i]) Failures"
            label.sizeToFit()
        }
    }
    
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "selectTeam", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTeam"?:
            let controller = segue.destination as! SelectTeamViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.numberOfPlayers = gameInfo.playersInTeam[gameInfo.rounds.count - 1]
        default:
            preconditionFailure("Wrong segue identifier")
        }
    }
    
    
    func createNewRound() {
        roundInfo = RoundInfo()
        gameInfo.rounds.append(roundInfo)
    }
}
