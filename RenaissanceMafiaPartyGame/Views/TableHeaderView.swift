//
//  TableHeaderView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 24/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {
    
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        textLabel = UILabel(frame: CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 20))
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        addSubview(textLabel)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createBottomLine().cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.position = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func createBottomLine() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: self.frame.height - 5))
        path.addLine(to: CGPoint(x: self.frame.width - 4, y: self.frame.height - 5))
        return path
    }
    
}
