//
//  SelectClassesViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData


class SelectAdditionalClassesViewController: UIViewController, TableButtonDelegate {
    
    
    var gameInfo: GameInfo!
    var goodClassesAvailable = [GameClass]()
    var evilClassesAvailable = [GameClass]()
    var expansionsAvailable = [Expansion]()
    var goodClassesSelected = 0
    var evilClassesSelected = 0
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let evilRequest = NSFetchRequest<GameClass>(entityName: "GameClass")
            evilRequest.predicate = NSPredicate(format: "isAdditional == YES AND isGood == NO")
            evilClassesAvailable = try managedContext.fetch(evilRequest)
            
            let goodRequest = NSFetchRequest<GameClass>(entityName: "GameClass")
            goodRequest.predicate = NSPredicate(format: "isAdditional == YES AND isGood == YES")
            goodClassesAvailable = try managedContext.fetch(goodRequest)
            
            expansionsAvailable = try managedContext.fetch(Expansion.fetchRequest())
        } catch {
            print(error)
        }
        
        let tableView = self.childViewControllers.first as! SelectAdditionalClassesTableViewController
        tableView.selectClassesViewController = self
        tableView.evilClassesAvailable = evilClassesAvailable
        tableView.goodClassesAvailable = goodClassesAvailable
        tableView.expansionsAvailable = expansionsAvailable
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        headerView.textLabel.text = "Select up to \(gameInfo.goodClassesCount - 1) good and \(gameInfo.evilClassesCount - 1) evil classes and as many expansions as you wish."
        tableView.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.delegate = self
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        footerView.backgroundColor = UIColor.white
        tableView.tableView.tableFooterView = footerView
    }

    
    
    func touchUp() {
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
            for i in 0..<gameInfo.goodClassesCount - goodClassesSelected {
                if i == 0 {
                    gameInfo.classes.append(wizard)
                } else {
                    gameInfo.classes.append(knight)
                }
            }
            for i in 0..<gameInfo.evilClassesCount - evilClassesSelected {
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
    
    var evilClassesAvailable: [GameClass]!
    var goodClassesAvailable: [GameClass]!
    var expansionsAvailable: [Expansion]!
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
            cell.nameLabel.text = goodClassesAvailable[indexPath.row].name!
            cell.descriptionLabel.text = goodClassesAvailable[indexPath.row].about!
        } else if indexPath.section == 1 {
            cell.nameLabel.text = evilClassesAvailable[indexPath.row].name!
            cell.descriptionLabel.text = evilClassesAvailable[indexPath.row].about!
        } else if indexPath.section == 2 {
            cell.nameLabel.text = expansionsAvailable[indexPath.row].name!
            cell.descriptionLabel.text = expansionsAvailable[indexPath.row].about!
        }
        cell.photo.image = UIImage(named: cell.nameLabel.text!)
        cell.infoButton.addTarget(self, action: #selector(showClassDetails(_:)), for: .touchUpInside)
        cell.infoButton.tag = indexPath.section * 10 + indexPath.row
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return goodClassesAvailable.count
        } else if section == 1 {
            return evilClassesAvailable.count
        }  else if section == 2 {
            return expansionsAvailable.count
        }
        return 0
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Good classes"
        } else if section == 1 {
            return "Evil classes"
        } else if section == 2 {
            return "Expansions"
        }
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if indexPath.section == 0 {
            if let index = selectClassesViewController.gameInfo.classes.index(of: goodClassesAvailable[indexPath.row]) {
                selectClassesViewController.gameInfo.classes.remove(at: index)
                selectClassesViewController.goodClassesSelected -= 1
                cell.accessoryType = .none
            } else if selectClassesViewController.goodClassesSelected != selectClassesViewController.gameInfo.goodClassesCount - 1 {
                selectClassesViewController.gameInfo.classes.append(goodClassesAvailable[indexPath.row])
                selectClassesViewController.goodClassesSelected += 1
                cell.accessoryType = .checkmark
            }
        } else if indexPath.section == 1 {
            if let index = selectClassesViewController.gameInfo.classes.index(of: evilClassesAvailable[indexPath.row]) {
                selectClassesViewController.gameInfo.classes.remove(at: index)
                selectClassesViewController.evilClassesSelected -= 1
                cell.accessoryType = .none
            } else if selectClassesViewController.evilClassesSelected != selectClassesViewController.gameInfo.evilClassesCount - 1{
                selectClassesViewController.gameInfo.classes.append(evilClassesAvailable[indexPath.row])
                selectClassesViewController.evilClassesSelected += 1
                cell.accessoryType = .checkmark
            }
        } else if indexPath.section == 2 {
            if let index = selectClassesViewController.gameInfo.expansions.index(of: expansionsAvailable[indexPath.row]) {
                selectClassesViewController.gameInfo.expansions.remove(at: index)
                cell.accessoryType = .none
            } else {
                selectClassesViewController.gameInfo.expansions.append(expansionsAvailable[indexPath.row])
                cell.accessoryType = .checkmark
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    @objc func showClassDetails(_ sender: UIButton) {
        let classDetails = ClassDetailViewController()
    
        if sender.tag / 10 == 0 {
            classDetails.gameClass = goodClassesAvailable[sender.tag % 10]
            classDetails.key = "Class"
        } else if sender.tag / 10 == 1 {
            classDetails.gameClass = evilClassesAvailable[sender.tag % 10]
            classDetails.key = "Class"
        } else if sender.tag / 10 == 2 {
            classDetails.expansion = expansionsAvailable[sender.tag % 10]
            classDetails.key = "Expansion"
        }
        
        classDetails.modalPresentationStyle = .overFullScreen
        classDetails.modalTransitionStyle = .crossDissolve
        self.present(classDetails, animated: true, completion: nil)
    }
}
