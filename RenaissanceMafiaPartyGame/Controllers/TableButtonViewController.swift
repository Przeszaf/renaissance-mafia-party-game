//
//  TableButtonViewController.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 22/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

protocol TableButtonDelegate {
    func touchUp()
}

class TableButtonViewController: UIViewController, UIGestureRecognizerDelegate {
    var nextButtonView: NextButtonView!
    var delegate: TableButtonDelegate?
    
    //MARK: - Lifecycle of VC
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        nextButtonView = NextButtonView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        nextButtonView.backgroundColor = UIColor.clear
        view.addSubview(nextButtonView)
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(tappedView(_:)))
        tapGesture.minimumPressDuration = 0
        view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Touch ups
    @objc func tappedView(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            nextButtonView.removeFromSuperview()
            nextButtonView = NextButtonView(frame: CGRect(x: 5, y: 5, width: view.frame.width, height: 40))
            view.addSubview(nextButtonView)
        } else if sender.state == .ended  {
            nextButtonView.removeFromSuperview()
            nextButtonView = NextButtonView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
            view.addSubview(nextButtonView)
            if sender.location(in: nextButtonView).y > 0 {
                delegate?.touchUp()
            }
        }
    }
}
