//
//  AllPlayersViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class AllPlayersViewController: UITableViewController, UITextViewDelegate {
    
    var playerStore: PlayerStore!
    var addingPlayer = false
    var currentCell: Int?
    
    var toolbar: UIToolbar!
    
    //MARK: - Overriding functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registering cells so we can use them
        tableView.register(AllPlayersCell.self, forCellReuseIdentifier: "AllPlayersCell")
        tableView.register(AddPlayersCell.self, forCellReuseIdentifier: "AddPlayersCell")
        tableView.rowHeight = 50
        //Adding right and left bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonBar))
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddingPlayerButtonPressed))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addPlayer))
        
        toolbar = createToolbarWith(leftButton: cancelButton, rightButton: doneButton)
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //If we want to add new player, then create additional cell
        if indexPath.row == playerStore.allPlayers.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayersCell", for: indexPath) as! AddPlayersCell
            cell.addButton.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
            cell.playerName.inputAccessoryView = toolbar
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPlayersCell", for: indexPath) as! AllPlayersCell
        cell.playerName.text = playerStore.allPlayers[indexPath.row].name
        
        //Get last time played
        if let lastTimePlayed = playerStore.allPlayers[indexPath.row].lastTimePlayed {
            cell.playerDate.text = lastTimePlayed.toStringWithHour()
        } else {
            cell.playerDate.text = "00-00-0000 00:00"
        }
        
        //How many times played
        let timesPlayed = playerStore.allPlayers[indexPath.row].timesPlayed
        if timesPlayed == 0 {
            cell.playerTimesPlayed.text = "Never played yet"
        } else {
            cell.playerTimesPlayed.text = "\(playerStore.allPlayers[indexPath.row].timesPlayed) times played"
        }
        cell.playerTimesPlayed.textColor = Constants.Global.detailTextColor
        //Make playerName textView editable if table is editing and vice versa
        if isEditing {
            cell.playerName.isEditable = true
            cell.playerName.isUserInteractionEnabled = true
        } else {
            cell.playerName.isEditable = false
            cell.playerName.isUserInteractionEnabled = false
        }
        cell.playerName.delegate = self
        cell.playerName.tag = indexPath.row
        cell.playerName.backgroundColor = UIColor.clear
        
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addingPlayer {
            return playerStore.allPlayers.count + 1
        }
        return playerStore.allPlayers.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < playerStore.allPlayers.count {
            let heightOfName = playerStore.allPlayers[indexPath.row].name.height(withConstrainedWidth: tableView.frame.width - 60, font: UIFont.systemFont(ofSize: 17))
            if let heightOfDate = playerStore.allPlayers[indexPath.row].lastTimePlayed?.toString().height(withConstrainedWidth: tableView.frame.width/2, font: UIFont.systemFont(ofSize: 17)) {
                return heightOfDate + heightOfName + 10
            }
        }
        return 52
    }
    
    
    
    //MARK: - Adding new players
    
    @IBAction func addButtonBar() {
        if isEditing {
            return
        }
        addingPlayer = true
        tableView.reloadData()
        DispatchQueue.main.async {
            //If add button in bar is touched, then scroll to bottom and make the new cell a first responder
            self.tableView.scrollToRow(at: IndexPath(item: self.playerStore.allPlayers.count, section: 0), at: .top, animated: false)
            let cell = self.tableView.cellForRow(at: IndexPath(item: self.playerStore.allPlayers.count, section: 0)) as! AddPlayersCell
            cell.playerName.becomeFirstResponder()
        }
    }
    
    @IBAction func addPlayer() {
        let cell = tableView.cellForRow(at: IndexPath(item: self.playerStore.allPlayers.count, section: 0)) as! AddPlayersCell
        
        //Cannot create player without name
        if cell.playerName.text == "" {
            
        } else {
            let player = Player(name: cell.playerName.text!)
            playerStore.addPlayer(player)
            addingPlayer = false
            cell.playerName.text = ""
            tableView.reloadData()
        }
    }
    
    
    @objc func cancelAddingPlayerButtonPressed() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: playerStore.allPlayers.count, section: 0)) as? AddPlayersCell else { return }
        addingPlayer = false
        cell.playerName.text = ""
        cell.resignFirstResponder()
        tableView.reloadData()
    }
    
    //MARK: - Deletions
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
        addingPlayer = false
        tableView.reloadData()
        var name = " "
        //If there is a cell already chosen, then get name of game
        if let row = currentCell, let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AllPlayersCell {
            name = cell.playerName.text
        }
        //If name is null, then do not let it end editing mode.
        if isEditing && name != "" {
            setEditing(false, animated: true)
            sender.title = "Edit"
            tableView.reloadData()
        } else {
            setEditing(true, animated: true)
            sender.title = "Done"
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Editing
    
    //Update game name if text changes
    func textViewDidChange(_ textView: UITextView) {
        playerStore.allPlayers[textView.tag].name = textView.text
        currentCell = textView.tag
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //If there is no text in game name TextView, then display alert and do not allow to end editing
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.layoutIfNeeded()
        if textView.text == "" {
            let alert = UIAlertController(title: nil, message: "Player name must have at least 1 character.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    func createToolbarWith(leftButton: UIBarButtonItem, rightButton: UIBarButtonItem) -> UIToolbar {
    let toolbar = UIToolbar()
    toolbar.barStyle = UIBarStyle.default
    toolbar.isTranslucent = true
    toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolbar.sizeToFit()
    
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    toolbar.setItems([leftButton, spaceButton, rightButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    return toolbar
    }
    
}