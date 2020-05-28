//
//  Canvas.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 27/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

// TODO: Improve canvas to use GPU rendering instead CPU for better performance.
//       Here is more info about GPU rendering
//       https://medium.com/@almalehdev/high-performance-drawing-on-ios-part-2-2cb2bc957f6
final class Canvas: UIView {
    
    // MARK: - Instance Properties
    
    var strokeColor: UIColor = .black
    var lineWidth: CGFloat = 1.0
    
    private var lines = [[CGPoint]]()
    
    // MARK: - Instance Methods
    
    func undo() {
        guard !lines.isEmpty else { return }
        lines.removeLast()
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard
            let position = touches.first?.location(in: nil),
            var lastLine = lines.popLast() else {
                return
        }

        lastLine.append(position)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }
}
