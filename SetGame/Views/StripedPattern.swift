//
//  StripedPattern.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import SwiftUI

struct StripedPattern: Shape {
    var stripeWidth: CGFloat
    var spacing: CGFloat
    var color: Color
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the number of stripes needed to fill the shape
        let stripeCount = Int(rect.height / (stripeWidth + spacing)) + 1
        
        for i in 0..<stripeCount {
            let yPosition = CGFloat(i) * (stripeWidth + spacing)
            
            let startPoint = CGPoint(x: rect.minX, y: yPosition)
            let endPoint = CGPoint(x: rect.maxX, y: yPosition)
            
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y + stripeWidth))
            path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + stripeWidth))
            path.closeSubpath()
        }
        
        return path
    }
}

