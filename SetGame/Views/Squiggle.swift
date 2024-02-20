//
//  Squiggle.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let startingPoint = CGPoint(x: rect.minX, y: rect.midY)

        let firstPoint = CGPoint(x: rect.width * 0.85, y: rect.height * 0.2)
        let curve1controlPoint1 = CGPoint(x: rect.width * 0.0, y: rect.height * -0.5)
        let curve1controlPoint2 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.6)

        let secondPoint = CGPoint(x: rect.width, y: rect.midY)
        let curve2controlPoint1 = CGPoint(x: rect.width * 0.88, y: rect.height * 0.05)
        let curve2controlPoint2 = CGPoint(x: rect.width, y: rect.height * 0.2)

        path.move(to: startingPoint)
        path.addCurve(to: firstPoint, control1: curve1controlPoint1, control2: curve1controlPoint2)
        path.addCurve(to: secondPoint, control1: curve2controlPoint1, control2: curve2controlPoint2)

        var lowerCurve = path
        lowerCurve = lowerCurve.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        lowerCurve = lowerCurve.applying(CGAffineTransform.identity
                    .translatedBy(x: rect.size.width, y: rect.size.height))

        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addPath(lowerCurve)

        return path
    }
}

#Preview {
    Squiggle()
}
