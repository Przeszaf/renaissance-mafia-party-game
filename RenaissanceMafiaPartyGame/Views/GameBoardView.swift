//
//  GameBoardView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 16/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class GameBoardView: UIView {
    
    var viewHeight: CGFloat?
    var fillColors: [UIColor]?
    
    var viewFrame: CGRect!
    
    let radius: CGFloat = 40
    
    var labels = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, fillColors: [UIColor]?) {
        self.init()
        self.viewFrame = frame
        self.fillColors = fillColors
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup() {
        let centerX: CGFloat = viewFrame.width / 2
        for i in 0..<5 {
            let centerY: CGFloat = 5 + radius + 2 * (5 + radius) * CGFloat(i)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = createCirclePath(centerX: centerX, centerY: centerY, radius: radius).cgPath
            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.lineWidth = 2
            if let colors = fillColors, i < colors.count {
                shapeLayer.fillColor = colors[i].cgColor
            } else {
                shapeLayer.fillColor = UIColor.clear.cgColor
            }
            shapeLayer.position = CGPoint(x: 0, y: 0)
            self.layer.addSublayer(shapeLayer)
            
            let label = UILabel(frame: CGRect(x: centerX + radius + 10, y: centerY - 13, width: 100, height: 2))
            label.numberOfLines = 2
            label.text = "X Players"
            label.sizeToFit()
            addSubview(label)
            labels.append(label)
        }
        
        self.layer.masksToBounds = true
    }
    
    
    func createCirclePath(centerX: CGFloat, centerY: CGFloat, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: centerX, y: centerY)
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        return path
    }
    
}
