//
//  ShowInfoViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 15/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ShowInfoViewController: UIViewController {
    
    var showInfoView: ShowInfoView!
    
    var players: [Player]!
    var visibility: [Player: [Player]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInfoView = ShowInfoView(frame: view.frame)
        view.addSubview(showInfoView)
        
        
        var string = ""
        for (player, visiblePlayers) in visibility {
            string.append("\(player.name) will see ")
            for visiblePlayer in visiblePlayers {
                string.append("\(visiblePlayer.name), ")
            }
            if visiblePlayers.isEmpty {
                string.append("no one")
            }
            string.append("\n")
        }
        showInfoView.label2.numberOfLines = 0
        showInfoView.label2.text = string
    }
}
