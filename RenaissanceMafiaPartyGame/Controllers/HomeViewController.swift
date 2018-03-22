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
        performSegue(withIdentifier: "startGame", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAllPlayers"?:
            let _ = segue.destination as! AllPlayersViewController
        case "startGame"?:
            let controller = segue.destination as! MainGameViewController
            controller.chosenClasses = GameClass.evil.array + GameClass.good.array
            do {
                let request = NSFetchRequest<Player>(entityName: "Player")
                request.fetchLimit = 4
                controller.players = try managedContext.fetch(request)
            } catch {
                print("Error fetching players \(error)")
            }
        default:
            preconditionFailure("Wronge segue identifier!")
        }
    }
}
