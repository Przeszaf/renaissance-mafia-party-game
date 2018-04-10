//
//  ClassDetailViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    var gameClass: GameClass!
    var expansion: Expansion!
    var key: String!
    var classDetailView: ClassDetailView!
    
    //MARK: - Lifecycle of VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding blur effect
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        view.alpha = 0
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        
        //Creating view
        classDetailView = ClassDetailView(frame: CGRect(x: 50, y: 50, width: view.frame.width - 100, height: 350))
        
        //Different labels and images depending on segue key
        if key == "Class" {
            classDetailView.imageView.image = UIImage(named: gameClass.name!)
            classDetailView.nameLabel.text = gameClass.name!
            classDetailView.descriptionLabel.text = gameClass.about!
        } else if key == "Expansion" {
            classDetailView.imageView.image = UIImage(named: expansion.name!)
            classDetailView.nameLabel.text = expansion.name!
            classDetailView.descriptionLabel.text = expansion.about!
        }
        classDetailView.alpha = 0.985
        self.view.addSubview(blurView)
        view.addSubview(classDetailView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1) {
            self.classDetailView.alpha = 1
        }
    }
    
    //Dismiss when touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
}
