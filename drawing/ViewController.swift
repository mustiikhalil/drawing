//
//  ViewController.swift
//  drawing
//
//  Created by Mustafa Khalil on 1/4/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class Canvas: UIView {
 
    var lines: [[CGPoint]] = []
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var line = lines.popLast() else { return }
        line.append(point)
        lines.append(line)
        
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {

    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.backgroundColor = .white
        view.addSubview(canvas)
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
}

