//
//  HomeViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var playerStore: PlayerStore!
    var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView = HomeView(frame: view.frame)
        view.addSubview(homeView)
        
        homeView.button.addTarget(self, action: #selector(seeAllPlayersButtonPressed(_:)), for: .touchUpInside)
        homeView.button2.addTarget(self, action: #selector(startGameButtonPressed(_:)), for: .touchUpInside)
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
            let controller = segue.destination as! AllPlayersViewController
            controller.playerStore = playerStore
        case "startGame"?:
            let controller = segue.destination as! MainGameViewController
            controller.players = playerStore.allPlayers
            controller.chosenClasses = [GameClasses.Knight, GameClasses.Knight, GameClasses.Assassin, GameClasses.Bandit, GameClasses.Wizard]
        default:
            preconditionFailure("Wronge segue identifier!")
        }
    }
}
