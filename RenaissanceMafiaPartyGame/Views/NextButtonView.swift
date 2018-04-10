//
//  NextButtonView.swift
//  RenaissanceMafiaPartyGame
//
//  Created by Przemyslaw Szafulski on 28/03/2018.
//  Copyright © 2018 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class NextButtonView: UIView {
    
    var button: UIButton!
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        button = UIButton(type: .system)
        button.frame = self.frame
        button.backgroundColor = UIColor.clear
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isUserInteractionEnabled = false
        setup()
        addSubview(button)
        self.backgroundColor = UIColor.clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        
        //Creating path
        let shapeLayer = CAShapeLayer()
        let path = createBezierPath(x: 3, y: 3, radius: 10)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.lightText.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.position = CGPoint(x: 0, y: 0)
        layer.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        
        
        //Creating Gradient
        let gradientFramePath = createBezierPath(x: 0, y: 0, radius: 10)
        let gradient = CAGradientLayer()
        gradient.frame = gradientFramePath.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 3, y: 1)
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = path.cgPath
        gradient.mask = shapeMask
        self.layer.addSublayer(gradient)
    }
    
    func createBezierPath(x: CGFloat, y: CGFloat, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        //Top line
        path.move(to: CGPoint(x: x + radius, y: y))
        path.addLine(to: CGPoint(x: self.frame.width - x - radius, y: y))
        
        //Top-right arc
        var centerPoint = CGPoint(x: self.frame.width - x - radius, y: y + radius)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: CGFloat(3*Double.pi / 2), endAngle: 0, clockwise: true)
        
        //Right line
        path.addLine(to: CGPoint(x: self.frame.width - x, y: self.frame.height - y - radius))
        
        //Right-bottom arc
        centerPoint = CGPoint(x: self.frame.width - x - radius, y: self.frame.height - y - radius)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        
        //Bottom line
        path.addLine(to: CGPoint(x: x + radius, y: self.frame.height - y))
        
        //Bottom-left line
        centerPoint = CGPoint(x: x + radius, y: self.frame.height - y - radius)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: CGFloat(Float.pi/2), endAngle: CGFloat(Float.pi), clockwise: true)
        
        //Left line
        path.addLine(to: CGPoint(x: x, y: y + radius))
        
        //Top-left arc
        centerPoint = CGPoint(x: x + radius, y: y + radius)
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi*3 / 2), clockwise: true)
        return path
    }
}
