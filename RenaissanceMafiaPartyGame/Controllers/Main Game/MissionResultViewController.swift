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
        
        let buttonViewController = childViewControllers.last! as! TableButtonViewController
        buttonViewController.delegate = self
        
        let tableViewController = childViewControllers.first! as! MissionResultTableViewController
        tableViewController.players = gameInfo.players
        tableViewController.playersMissionDecision = roundInfo.playersMissionDecision
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        if selectedTeamGoes {
            headerView.textLabel.text = "Most people agreed! This team goes for a quest."
        } else {
            headerView.textLabel.text = "Most people disagreed! Please select another team."
        }
        tableViewController.tableView.tableHeaderView = headerView
        tableViewController.missionAccepted = selectedTeamGoes
    }
    
    func touchUp() {
        if selectedTeamGoes {
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

class MissionResultTableViewController: UITableViewController, CAAnimationDelegate {
    
    var players: [Player]!
    var playersMissionDecision: [Player: Bool]!
    var gradientLayer: CAGradientLayer!
    var missionAccepted: Bool!
    let fromColors = [UIColor(red: 0.5, green: 0, blue: 1, alpha: 1).cgColor, UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor]
    
    //MARK: - Overriding functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        var toColors = [CGColor]()
        if missionAccepted {
            toColors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        } else {
            toColors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        }
        let gradientColorAnimation = CABasicAnimation(keyPath: "colors")
        gradientColorAnimation.fromValue = fromColors
        gradientColorAnimation.toValue = toColors
        gradientColorAnimation.duration = 4.00
        gradientColorAnimation.isRemovedOnCompletion = false
        gradientColorAnimation.fillMode = kCAFillModeBoth
        gradientColorAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        gradientLayer.add(gradientColorAnimation, forKey: "animateGradient")
        
        gradientColorAnimation.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registering cells so we can use them
        tableView.register(MissionResultCell.self, forCellReuseIdentifier: "MissionResultCell")
        tableView.rowHeight = 50
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clear
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoints = CGPoint(x: 1, y: 2.5)
        configureGradient(colors: fromColors, startPoint: startPoint, endPoint: endPoints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    
    func configureGradient(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        gradientLayer.frame = tableView.bounds
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
    }
    
}

