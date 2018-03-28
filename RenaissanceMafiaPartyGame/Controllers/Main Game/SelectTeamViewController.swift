//
//  SelectTeamViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SelectTeamViewController: UIViewController, TableButtonDelegate {
    
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var numberOfPlayers: Int!
    var selectedPlayers = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = self.childViewControllers.first as! SelectTeamTableViewController
        tableView.players = gameInfo.players
        tableView.numberOfPlayers = numberOfPlayers
        tableView.selectTeamViewController = self
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Hello \(gameInfo.currentLeader.name!)! Select \(numberOfPlayers!) that should go on mission!"
        tableView.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.delegate = self
        
        
    }
    

    @objc func touchUp() {
        if selectedPlayers.count == numberOfPlayers {
            performSegue(withIdentifier: "askMissionAgreement", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "askMissionAgreement" {
            let controller = segue.destination as! MissionAgreementViewController
            controller.roundInfo = roundInfo
            controller.gameInfo = gameInfo
            controller.selectedPlayers = selectedPlayers
        }
    }
}



class SelectTeamTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var players: [Player]!
    var numberOfPlayers: Int!
    
    var selectTeamViewController: SelectTeamViewController!
    
    //MARK: - Overriding functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registering cells so we can use them
        tableView.register(SelectPlayersCell.self, forCellReuseIdentifier: "SelectPlayersCell")
        tableView.rowHeight = 50
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let player = players[indexPath.row]
        if selectTeamViewController.selectedPlayers.index(of: player) != nil {
            return indexPath
        }
        if selectTeamViewController.selectedPlayers.count == numberOfPlayers {
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPlayersCell", for: indexPath) as! SelectPlayersCell
        let player = players[indexPath.row]
        cell.playerName.text = player.name
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let index = selectTeamViewController.selectedPlayers.index(of: player) {
            selectTeamViewController.selectedPlayers.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectTeamViewController.selectedPlayers.append(player)
            cell.accessoryType = .checkmark
        }
    }
    
    
}

