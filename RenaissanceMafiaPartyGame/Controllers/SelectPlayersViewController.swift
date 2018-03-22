//
//  SelectPlayersViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData


class SelectPlayersViewController: UIViewController {
    
    var selectedPlayers = [Player]()
    var numberOfPlayers: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = self.childViewControllers.first as! SelectPlayersTableViewController
        tableView.selectPlayersViewController = self
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.button.addTarget(self, action: #selector(nextButtonHoldDown(_:)), for: .touchDown)
        buttonViewController.button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func nextButtonHoldDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        if selectedPlayers.count >= 2 {
            performSegue(withIdentifier: "selectClasses", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectClasses" {
            let controller = segue.destination as! SelectClassesViewController
            controller.selectedPlayers = selectedPlayers
        }
    }
}


class SelectPlayersTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var players: [Player]!
    var selectedPlayers = [Player]()
    
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
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let player = players[indexPath.row]
        if selectPlayersViewController.selectedPlayers.index(of: player) != nil {
            return indexPath
        }
        if selectPlayersViewController.selectedPlayers.count == 10 {
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
        if let index = selectPlayersViewController.selectedPlayers.index(of: player) {
            selectPlayersViewController.selectedPlayers.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectPlayersViewController.selectedPlayers.append(player)
            cell.accessoryType = .checkmark
        }
    }
    
}
