//
//  SwordOfDistrustAskViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 29/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class SwordOfDistrustAskViewController: UIViewController {
    
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var selectedPlayers: [Player]!
    var playerWithSword: Player!
    
    var swordOfDistrustAskView: SwordOfDistrustAskView!
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the view
        swordOfDistrustAskView = SwordOfDistrustAskView(frame: view.frame)
        swordOfDistrustAskView.askLabel.text = "Do you want to use the sword?\nDoing so will change the decision of one player.\nSuccess will become Failure and Failure will become Success.\nChoose wisely."
        swordOfDistrustAskView.yesButton.addTarget(self, action: #selector(yesButtonPressed(_:)), for: .touchUpInside)
        swordOfDistrustAskView.noButton.addTarget(self, action: #selector(noButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(swordOfDistrustAskView)
    }
    
    //MARK: - Buttons
    @objc func yesButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "swordOfDistrustUse", sender: self)
    }
    
    @objc func noButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "swordOfDistrustNotUse", sender: self)
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swordOfDistrustUse" {
            let controller = segue.destination as! SwordOfDistrustUseViewController
            controller.gameInfo = gameInfo
            controller.roundInfo = roundInfo
            controller.selectedPlayers = selectedPlayers
            controller.playerWithSword = playerWithSword
        }
    }
}
