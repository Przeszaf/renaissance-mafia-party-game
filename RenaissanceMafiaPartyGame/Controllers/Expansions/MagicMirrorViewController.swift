//
//  MagicMirrorViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 27/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MagicMirrorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var players: [Player]!
    var selectedPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        players = gameInfo.players
        let index = players.index(of: gameInfo.magicMirrorOwner)!
        players.remove(at: index)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.frame = CGRect(x: 0, y: view.frame.height - 40, width: view.frame.width, height: 40)
        button.backgroundColor = UIColor.green
        view.addSubview(button)
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Which player do you want to check? You are using Magic Mirror!"
        tableView.tableHeaderView = headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row].name!
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let player = players[indexPath.row]
        if selectedPlayer != nil {
            if player != selectedPlayer {
                return nil
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let player = players[indexPath.row]
        if selectedPlayer != nil {
            if player == selectedPlayer {
                selectedPlayer = nil
                cell.accessoryType = .none
            }
        } else {
            selectedPlayer = players[indexPath.row]
            cell.accessoryType = .checkmark
        }
    }
    
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        if selectedPlayer != nil {
            performSegue(withIdentifier: "showUserClass", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserClass" {
            let controller = segue.destination as! MagicMirrorResultViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.player = selectedPlayer!
        }
    }
}
