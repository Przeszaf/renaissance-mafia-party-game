//
//  SelectClassesViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData


class SelectClassesViewController: UIViewController {
    
    var selectedPlayers: [Player]!
    var selectedClasses = [GameClass]()
    var classes: [GameClass]!
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchedClasses: [GameClass] = try managedContext.fetch(GameClass.fetchRequest())
            classes = fetchedClasses.sorted(by: { (firstClass, secondClass) -> Bool in
                if firstClass.name == "Bandit" || firstClass.name == "Knight" {
                    return false
                }
                return true
            })
        } catch {
            print("Error fetching classes \(error)")
        }
        
        let tableView = self.childViewControllers.first as! SelectClassesTableViewController
        tableView.selectClassesViewController = self
        tableView.classes = classes
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.button.addTarget(self, action: #selector(nextButtonHoldDown(_:)), for: .touchDown)
        buttonViewController.button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func nextButtonHoldDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        if selectedClasses.count < selectedPlayers.count {
            selectedClasses.append(classes.last!)
        } else {
            performSegue(withIdentifier: "startGame", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            let controller = segue.destination as! MainGameViewController
            controller.players = selectedPlayers
            controller.chosenClasses = selectedClasses
        }
    }
}


class SelectClassesTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var classes: [GameClass]!
    var selectClassesViewController: SelectClassesViewController!
    
    //MARK: - Overriding functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registering cells so we can use them
        //FIXME: Change cells to better
        tableView.register(GameClassCell.self, forCellReuseIdentifier: "GameClassCell")
        tableView.rowHeight = 50
        
    }
    
    
    //MARK: - UITableView - conforming etc
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameClassCell", for: indexPath) as! GameClassCell
        
        cell.nameLabel.text = classes[indexPath.row].name!
        cell.photo.backgroundColor = UIColor(red: 0.5, green: 0, blue: 1, alpha: 0.3)
        cell.descriptionLabel.text = classes[indexPath.row].about!
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row >= classes.count - 2 {
            return nil
        }
        return indexPath
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let index = selectClassesViewController.selectedClasses.index(of: classes[indexPath.row]) {
            selectClassesViewController.selectedClasses.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectClassesViewController.selectedClasses.append(classes[indexPath.row])
            cell.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
