//
//  HomeViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    var homeView: HomeView!
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView = HomeView(frame: view.frame)
        view.addSubview(homeView)
        
        homeView.button.addTarget(self, action: #selector(seeAllPlayersButtonPressed(_:)), for: .touchUpInside)
        homeView.button2.addTarget(self, action: #selector(startGameButtonPressed(_:)), for: .touchUpInside)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    
    
    @objc func seeAllPlayersButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showAllPlayers", sender: nil)
    }
    
    @objc func startGameButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "selectPlayers", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAllPlayers"?:
            let _ = segue.destination as! AllPlayersViewController
        case "selectPlayers"?:
            let _ = segue.destination as! SelectPlayersViewController
        default:
            preconditionFailure("Wronge segue identifier!")
        }
    }
}
