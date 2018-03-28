//
//  MissionResultViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MissionResultViewController: UIViewController, TableButtonDelegate {
    
    var roundInfo: RoundInfo!
    var gameInfo: GameInfo!
    var selectedPlayers: [Player]!
    var selectedTeamGoes: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonViewController = childViewControllers.last! as! TableButtonViewController
        buttonViewController.delegate = self
        
        let tableViewController = childViewControllers.first! as! MissionResultTableViewController
        tableViewController.players = gameInfo.players
        tableViewController.playersMissionDecision = roundInfo.playersMissionDecision
        
        var teamAccepted = 0
        var teamNotAccepted = 0
        for (_, decision) in roundInfo.playersMissionDecision {
            if decision == true {
                teamAccepted += 1
            } else {
                teamNotAccepted += 1
            }
        }
        if teamAccepted < teamNotAccepted {
            selectedTeamGoes = false
            roundInfo.failedMissionsCount += 1
        } else {
            selectedTeamGoes = true
        }
        
    }
    
    func touchUp() {
        if selectedTeamGoes == true {
            performSegue(withIdentifier: "missionAgreed", sender: self)
        } else {
            gameInfo.nextLeader()
            let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainGameViewController") as! MainGameViewController
            mainVC.roundInfo = roundInfo
            mainVC.gameInfo = gameInfo
            show(mainVC, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "missionAgreed" {
            let controller = segue.destination as! QuestPhaseViewController
            controller.selectedPlayers = selectedPlayers
            controller.roundInfo = roundInfo
            controller.gameInfo = gameInfo
        }
    }
}

class MissionResultTableViewController: UITableViewController {
    
    var players: [Player]!
    var playersMissionDecision: [Player: Bool]!
    
    //MARK: - Overriding functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registering cells so we can use them
        tableView.register(MissionResultCell.self, forCellReuseIdentifier: "MissionResultCell")
        tableView.rowHeight = 50
        tableView.allowsSelection = false
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionResultCell", for: indexPath) as! MissionResultCell
        let player = players[indexPath.row]
        cell.playerNameLabel.text = player.name
        
        let decision = playersMissionDecision[player]
        if decision == true {
            cell.decisionLabel.text = "Agree"
            cell.decisionLabel.textColor = UIColor.green
        } else if decision == false {
            cell.decisionLabel.text = "Disagree"
            cell.decisionLabel.textColor = UIColor.red
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    
}

