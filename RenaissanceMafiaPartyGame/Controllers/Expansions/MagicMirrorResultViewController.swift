//
//  MagicMirrorResultViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 28/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class MagicMirrorResultViewController: UIViewController {
    
    var magicMirrorResultView: MagicMirrorResultView!
    var gameInfo: GameInfo!
    var roundInfo: RoundInfo!
    var player: Player!
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up view
        magicMirrorResultView = MagicMirrorResultView(frame: view.frame)
        let playerClass = gameInfo.playersClasses[player]!
        magicMirrorResultView.classLabel.text = "\(player.name!) is \(playerClass.isGood ? "Good" : "Evil") character."
        magicMirrorResultView.remainderLabel.text = "Remember not to show the screen to anyone! This information is only for you!\nTap anywhere to continue."
        
        magicMirrorResultView.classLabel.isHidden = true
        magicMirrorResultView.classLabel.alpha = 0
        
        magicMirrorResultView.fractionImage.isHidden = true
        magicMirrorResultView.fractionImage.alpha = 0
        
        
        view.addSubview(magicMirrorResultView)
    }
    
    //Change view when touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if magicMirrorResultView.classLabel.isHidden {
            magicMirrorResultView.classLabel.isHidden = false
            magicMirrorResultView.fractionImage.isHidden = false
            UIView.animate(withDuration: 1, animations: {
                self.magicMirrorResultView.classLabel.alpha = 1
                self.magicMirrorResultView.fractionImage.alpha = 1
                self.magicMirrorResultView.remainderLabel.alpha = 0
            }) { (completed) in
                self.magicMirrorResultView.remainderLabel.isHidden = true
                self.gameInfo.magicMirrorOwner = self.player
            }
        }
        else {
            let mainGameVC = storyboard?.instantiateViewController(withIdentifier: "MainGameViewController") as! MainGameViewController
            mainGameVC.gameInfo = gameInfo
            mainGameVC.roundInfo = roundInfo
            show(mainGameVC, sender: self)
        }
    }
}
