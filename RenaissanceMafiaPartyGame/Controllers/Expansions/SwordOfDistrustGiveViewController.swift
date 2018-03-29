//
//  SwordOfDistrustGiveViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 29/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SwordOfDistrustGiveViewController: UIViewController, TableButtonDelegate {
    
    
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var selectedPlayers: [Player]!
    var playersAvailable: [Player]!
    var selectedPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersAvailable = selectedPlayers
        print(selectedPlayers)
        print(playersAvailable)
        if let index = playersAvailable.index(of: gameInfo.currentLeader) {
            playersAvailable.remove(at: index)
        }
        
        let tableViewController = childViewControllers.first! as! SwordOfDistrustGiveTableViewController
        tableViewController.parentView = self
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Who do you want give sword of distrust to?"
        tableViewController.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last! as! TableButtonViewController
        buttonViewController.delegate = self
    }
    
    
    func touchUp() {
        if selectedPlayer != nil {
            performSegue(withIdentifier: "swordOfDistrustAsk", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swordOfDistrustAsk" {
            let controller = segue.destination as! SwordOfDistrustAskViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.selectedPlayers = selectedPlayers
            controller.playerWithSword = selectedPlayer!
        }
    }
}

class SwordOfDistrustGiveTableViewController: UITableViewController {
    var parentView: SwordOfDistrustGiveViewController!
    
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
