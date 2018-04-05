//
//  SwordOfDistrustUseViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 29/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SwordOfDistrustUseViewController: UIViewController, TableButtonDelegate {
    
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var selectedPlayers: [Player]!
    var playerWithSword: Player!
    
    var playersAvailable: [Player]!
    var selectedPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersAvailable = selectedPlayers
        let index = playersAvailable.index(of: playerWithSword)!
        playersAvailable.remove(at: index)
        
        let tableViewController = childViewControllers.first! as! SwordOfDistrustUseTableViewController
        tableViewController.parentView = self
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Who do you want to use the sword on?"
        tableViewController.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last! as! TableButtonViewController
        buttonViewController.delegate = self
    }
    
    
    func touchUp() {
        if selectedPlayer != nil {
            roundInfo.playersQuestDecision[selectedPlayer!] = !roundInfo.playersQuestDecision[selectedPlayer!]!
            performSegue(withIdentifier: "questResults", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questResults" {
            let controller = segue.destination as! QuestResultViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.swordUsedByPlayer = playerWithSword
            controller.swordUsedOnPlayer = selectedPlayer
        }
    }
}

class SwordOfDistrustUseTableViewController: UITableViewController {
    var parentView: SwordOfDistrustUseViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = parentView.playersAvailable[indexPath.row].name!
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentView.playersAvailable.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let player = parentView.playersAvailable[indexPath.row]
        if parentView.selectedPlayer != nil {
            if player != parentView.selectedPlayer {
                return nil
            }
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let player = parentView.playersAvailable[indexPath.row]
        if parentView.selectedPlayer != nil {
            if player == parentView.selectedPlayer {
                parentView.selectedPlayer = nil
                cell.accessoryType = .none
            }
        } else {
            parentView.selectedPlayer = parentView.playersAvailable[indexPath.row]
            cell.accessoryType = .checkmark
        }
    }
}
