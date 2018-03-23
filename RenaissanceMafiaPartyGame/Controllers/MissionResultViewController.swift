//
//  MissionResultViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 17/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MissionResultViewController: UIViewController {
    
    var players: [Player]!
    var selectedPlayers: [Player]!
    var playersDecision: [Player: Bool]!
    var playersClasses: [Player: GameClass]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonViewController = childViewControllers.last! as! TableButtonViewController
        buttonViewController.button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        
        let tableViewController = childViewControllers.first! as! MissionResultTableViewController
        tableViewController.players = players
        tableViewController.playersDecision = playersDecision
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "missionAgreed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "missionAgreed" {
            let controller = segue.destination as! QuestPhaseViewController
            controller.selectedPlayers = selectedPlayers
            controller.playersClasses = playersClasses
        }
    }
}

class MissionResultTableViewController: UITableViewController {
    
    var players: [Player]!
    var playersDecision: [Player: Bool]!
    
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
        
        let decision = playersDecision[player]
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

