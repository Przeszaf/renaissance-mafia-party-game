//
//  SelectPlayersViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData


class SelectPlayersViewController: UIViewController, TableButtonDelegate {
    
    
    let gameInfo = GameInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = self.childViewControllers.first as! SelectPlayersTableViewController
        tableView.selectPlayersViewController = self
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.delegate = self
        
    }
    
    func touchUp() {
        if gameInfo.players.count >= 5 {
            performSegue(withIdentifier: "selectAdditionalClasses", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectAdditionalClasses" {
            gameInfo.setClassesCount()
            let controller = segue.destination as! SelectAdditionalClassesViewController
            controller.gameInfo = gameInfo
        }
    }
}


class SelectPlayersTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var players: [Player]!
    var managedContext: NSManagedObjectContext!
    
    var selectPlayersViewController: SelectPlayersViewController!
    
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            players = try managedContext.fetch(Player.fetchRequest())
        } catch {
            print("Error fetching players \(error)")
        }
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Select from 5 up to 10 players!"
        tableView.tableHeaderView = headerView
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let player = players[indexPath.row]
        if selectPlayersViewController.gameInfo.players.index(of: player) != nil {
            return indexPath
        }
        if selectPlayersViewController.gameInfo.players.count == 10 {
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPlayersCell", for: indexPath) as! SelectPlayersCell
        let player = players[indexPath.row]
        cell.playerName.text = player.name
        if let index = selectPlayersViewController.gameInfo.players.index(of: player) {
            cell.playerPosition.text = "\(index + 1)."
        } else {
            cell.playerPosition.text = nil
        }
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? SelectPlayersCell else { return }
        if let index = selectPlayersViewController.gameInfo.players.index(of: player) {
            selectPlayersViewController.gameInfo.players.remove(at: index)
            cell.accessoryType = .none
            tableView.reloadData()
        } else {
            selectPlayersViewController.gameInfo.players.append(player)
            cell.accessoryType = .checkmark
            cell.playerPosition.text = "\(selectPlayersViewController.gameInfo.players.count)."
        }
    }
    
}
