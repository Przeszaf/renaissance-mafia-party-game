//
//  SelectTeamViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SelectTeamViewController: UIViewController {
    
    var players: [Player]!
    var selectedPlayers = [Player]()
    var playersClasses: [Player: String]!
    var numberOfPlayers: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = self.childViewControllers.first as! SelectTeamTableViewController
        tableView.players = players
        tableView.numberOfPlayers = numberOfPlayers
        tableView.selectTeamViewController = self
        
        let buttonViewController = childViewControllers.last as! SelectTeamButtonViewController
        buttonViewController.button.addTarget(self, action: #selector(nextButtonHoldDown(_:)), for: .touchDown)
        buttonViewController.button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func nextButtonHoldDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        if selectedPlayers.count == numberOfPlayers {
            performSegue(withIdentifier: "askMissionAgreement", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "askMissionAgreement" {
            let controller = segue.destination as! MissionAgreementViewController
            controller.players = players
            controller.selectedPlayers = selectedPlayers
            controller.playersClasses = playersClasses
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


class SelectTeamButtonViewController: UIViewController {
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        print(button.frame)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.backgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 0.4)
        view.addSubview(button)
    }
}
