//
//  Card.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import Foundation

struct Card: Identifiable, Equatable{
    let id: Int
    let color: CardColor
    let shape: CardShape
    let shading: CardShading
    let number: CardNumber
    var isChosen = false
    var isMatched = false
    var isNotMatched = false
}
