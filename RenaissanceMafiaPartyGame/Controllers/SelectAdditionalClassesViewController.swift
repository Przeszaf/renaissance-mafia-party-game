//
//  SelectClassesViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData


class SelectAdditionalClassesViewController: UIViewController {
    
    var gameInfo: GameInfo!
    var goodClasses = [GameClass]()
    var evilClasses = [GameClass]()
    var goodClassesCount = 0
    var evilClassesCount = 0
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        let tableView = self.childViewControllers.first as! SelectAdditionalClassesTableViewController
        tableView.selectClassesViewController = self
        tableView.evilClasses = evilClasses
        tableView.goodClasses = goodClasses
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "Select up to \(gameInfo.goodClassesCount - 1) good and \(gameInfo.evilClassesCount - 1) evil classes."
        tableView.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.button.addTarget(self, action: #selector(nextButtonHoldDown(_:)), for: .touchDown)
        buttonViewController.button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    @objc func nextButtonHoldDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.red
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        do {
            let classes: [GameClass] = try managedContext.fetch(GameClass.fetchRequest())
            var knight: GameClass!
            var wizard: GameClass!
            var bandit: GameClass!
            var assassin: GameClass!
            for gameClass in classes {
                if gameClass.name == "Knight" {
                    knight = gameClass
                } else if gameClass.name == "Wizard" {
                    wizard = gameClass
                } else if gameClass.name == "Bandit" {
                    bandit = gameClass
                } else if gameClass.name == "Assassin" {
                    assassin = gameClass
                }
            }
            for i in 0..<gameInfo.goodClassesCount {
                if i == 0 {
                    gameInfo.classes.append(wizard)
                } else {
                    gameInfo.classes.append(knight)
                }
            }
            for i in 0..<gameInfo.evilClassesCount {
                if i == 0 {
                    gameInfo.classes.append(assassin)
                } else {
                    gameInfo.classes.append(bandit)
                }
            }
            performSegue(withIdentifier: "showGameInfo", sender: self)
        } catch {
            print("Error \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameInfo" {
            let controller = segue.destination as! ShowGameInfoViewController
            gameInfo.setPlayersInRound()
            gameInfo.assignClasses()
            gameInfo.setVisibility()
            gameInfo.assignFirstLeader()
            controller.gameInfo = gameInfo
        }
    }
}


class SelectAdditionalClassesTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var evilClasses: [GameClass]!
    var goodClasses: [GameClass]!
    var selectClassesViewController: SelectAdditionalClassesViewController!
    
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
        
        if indexPath.section == 0 {
            cell.nameLabel.text = goodClasses[indexPath.row].name!
            cell.descriptionLabel.text = goodClasses[indexPath.row].about!
        } else if indexPath.section == 1 {
            cell.nameLabel.text = evilClasses[indexPath.row].name!
            cell.descriptionLabel.text = evilClasses[indexPath.row].about!
        }
        cell.photo.backgroundColor = UIColor(red: 0.5, green: 0, blue: 1, alpha: 0.3)
        cell.infoButton.addTarget(self, action: #selector(showClassDetails(_:)), for: .touchUpInside)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return goodClasses.count
        } else if section == 1 {
            return evilClasses.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectClassesViewController.goodClassesCount == selectClassesViewController.gameInfo.goodClassesCount {
            return nil
        }
        if selectClassesViewController.evilClassesCount == selectClassesViewController.gameInfo.evilClassesCount {
            return nil
        }
        return indexPath
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Good classes"
        } else if section == 1 {
            return "Evil classes"
        }
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if indexPath.section == 0 {
            if let index = selectClassesViewController.gameInfo.classes.index(of: goodClasses[indexPath.row]) {
                selectClassesViewController.gameInfo.classes.remove(at: index)
                selectClassesViewController.goodClassesCount -= 1
                cell.accessoryType = .none
            } else {
                selectClassesViewController.gameInfo.classes.append(goodClasses[indexPath.row])
                selectClassesViewController.goodClassesCount += 1
                cell.accessoryType = .checkmark
            }
        } else if indexPath.section == 1 {
            if let index = selectClassesViewController.gameInfo.classes.index(of: evilClasses[indexPath.row]) {
                selectClassesViewController.gameInfo.classes.remove(at: index)
                selectClassesViewController.evilClassesCount -= 1
                cell.accessoryType = .none
            } else {
                selectClassesViewController.gameInfo.classes.append(evilClasses[indexPath.row])
                selectClassesViewController.evilClassesCount += 1
                cell.accessoryType = .checkmark
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    @objc func showClassDetails(_ sender: UIButtonType) {
        let classDetails = ClassDetailViewController()
        classDetails.modalPresentationStyle = .overCurrentContext
        classDetails.modalTransitionStyle = .crossDissolve
        self.present(classDetails, animated: true, completion: nil)
    }
}
