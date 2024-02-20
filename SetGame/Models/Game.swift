//
//  Game.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import Foundation

struct SetGame{
    private(set) var deck: [Card]
    private(set) var cards: [Card]
    private(set) var selected: [Int] = []
    private(set) var score = 0
    
    init() {
        deck = []
        var count = 0
        for num in CardNumber.allCases{
            for col in CardColor.allCases{
                for sha in CardShape.allCases{
                    for shade in CardShading.allCases{
                        let card : Card = Card(id: count, color: col, shape: sha, shading: shade, number: num)
                        count += 1
                        self.deck.append(card)

                    }
                }
            }
        }
        deck.shuffle()
        
        self.cards = []
        for _ in 0..<4{
            cards += deal()!
        }
    }
    
    func checkMatchingSet() -> Bool{
        var setColor : Set<CardColor> = Set()
        var setShading: Set<CardShading> = Set()
        var setNumber: Set<CardNumber> = Set()
        var setShape: Set<CardShape> = Set()
        for index in selected{
            if let card = cards.first(where: { $0.id == index }){
                setColor.insert(card.color)
                setShading.insert(card.shading)
                setNumber.insert(card.number)
                setShape.insert(card.shape)
            }
        }
        return !(setColor.count == 2 || setShading.count == 2 || setNumber.count == 2 || setShape.count == 2)
    }
    
    mutating func shuffleDeck(){
        deck.shuffle()
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if selected.count == 3{
                if selected.contains(cards[chosenIndex].id){
                    for i in 0..<3{
                        if let index = cards.firstIndex(where: { $0.id == selected[i] }) {
                            cards[index].isNotMatched = false
                        }
                    }
                    for i in 0..<selected.count{
                        if selected[i] == cards[chosenIndex].id{
                            selected.remove(at: i)
                            break
                        }
                    }
                    cards[chosenIndex].isChosen.toggle()
                }else{
                    cards[chosenIndex].isChosen.toggle()
                    for i in 0..<3{
                        if let index = cards.firstIndex(where: { $0.id == selected[i] }) {
                            cards[index].isNotMatched = false
                            cards[index].isChosen = false
                        }
                    }
                    selected = [cards[chosenIndex].id]
                    
                }
            }else if selected.count < 3{
                if cards[chosenIndex].isChosen{
                    for i in 0..<selected.count{
                        if selected[i] == cards[chosenIndex].id{
                            selected.remove(at: i)
                            break
                        }
                    }
                }else{
                    selected.append(card.id)
                }
                cards[chosenIndex].isChosen.toggle()
                if selected.count == 3{
                    if checkMatchingSet(){
                        score += 1
                        for i in 0..<3{
                            if let index = cards.firstIndex(where: { $0.id == selected[i] }) {
                                cards[index].isMatched = true
                            }
                        }
                        
                        if cards.count <= 12{
                            for (index, card) in cards.enumerated() {
                                if selected.contains(where: { $0 == card.id }) {
                                    if let replacementCard = deck.popLast() {
                                        cards[index] = replacementCard
                                    }
                                }
                            }
                        }
                        
                        if deck.isEmpty || cards.count > 12{
                            selected.forEach { selectedIndex in
                                cards.removeAll { card in
                                    card.id == selectedIndex
                                }
                            }
                        }
                        selected = []
                    }else{
                        for i in 0..<3{
                            if let index = cards.firstIndex(where: { $0.id == selected[i] }) {
                                cards[index].isNotMatched = true
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    mutating func dealMoreCard(){
        if let moreCards = deal(){
            cards += moreCards
        }
    }
    
    mutating func deal() -> [Card]?{
        if deck.count >= 3{
            return [deck.removeLast(), deck.removeLast(), deck.removeLast()]
        }
        return nil
    }
    
    
}
