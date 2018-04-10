//
//  ShowGameInfoViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 24/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

import UIKit
import CoreData


class ShowGameInfoViewController: UIViewController, TableButtonDelegate {
    
    var gameInfo: GameInfo!
    var goodClasses = [GameClass]()
    var evilClasses = [GameClass]()
    var goodClassesCount = 0
    var evilClassesCount = 0
    
    var managedContext: NSManagedObjectContext!
    
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sort classes into good and evil
        for gameClass in gameInfo.classes {
            if gameClass.isGood {
                goodClasses.append(gameClass)
            } else {
                evilClasses.append(gameClass)
                print(evilClasses.map({$0.name!}))
            }
        }
        
        //Set up children table views
        let tableView = self.childViewControllers.first as! ShowGameInfoTableViewController
        tableView.evilClasses = evilClasses
        tableView.goodClasses = goodClasses
        tableView.expansions = gameInfo.expansions
        
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        headerView.textLabel.text = "You are playing with classes and expansions listed below."
        tableView.tableView.tableHeaderView = headerView
        
        let buttonViewController = childViewControllers.last as! TableButtonViewController
        buttonViewController.delegate = self
        
    }

    //MARK: - Segues
    @objc func touchUp() {
        if gameInfo.classes.count < gameInfo.players.count {
        } else {
            performSegue(withIdentifier: "showClassInfo", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showClassInfo" {
            let controller = segue.destination as! ShowClassInfoViewController
            controller.gameInfo = gameInfo
        }
    }
}

//MARK: - TableViewController
class ShowGameInfoTableViewController: UITableViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    var evilClasses: [GameClass]!
    var goodClasses: [GameClass]!
    var expansions: [Expansion]!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GameClassCell.self, forCellReuseIdentifier: "GameClassCell")
        tableView.rowHeight = 50
    }
    
    
    //MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameClassCell", for: indexPath) as! GameClassCell
        
        if indexPath.section == 0 {
            cell.nameLabel.text = goodClasses[indexPath.row].name!
            cell.descriptionLabel.text = goodClasses[indexPath.row].about!
        } else if indexPath.section == 1 {
            cell.nameLabel.text = evilClasses[indexPath.row].name!
            cell.descriptionLabel.text = evilClasses[indexPath.row].about!
        } else if indexPath.section == 2 {
            cell.nameLabel.text = expansions[indexPath.row].name!
            cell.descriptionLabel.text = expansions[indexPath.row].about!
        }
        cell.infoButton.tag = indexPath.section * 10 + indexPath.row
        cell.photo.image = UIImage(named: cell.nameLabel.text!)
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
        } else if section == 2 {
            return expansions.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    @objc func showClassDetails(_ sender: UIButton) {
        let classDetails = ClassDetailViewController()
        
        if sender.tag / 10 == 0 {
            classDetails.gameClass = goodClasses[sender.tag % 10]
            classDetails.key = "Class"
        } else if sender.tag / 10 == 1 {
            classDetails.gameClass = evilClasses[sender.tag % 10]
            classDetails.key = "Class"
        } else if sender.tag / 10 == 2 {
            classDetails.expansion = expansions[sender.tag % 10]
            classDetails.key = "Expansion"
        }
        
        //Present classDetails modally
        classDetails.modalPresentationStyle = .overFullScreen
        classDetails.modalTransitionStyle = .crossDissolve
        self.present(classDetails, animated: true, completion: nil)
    }
}
