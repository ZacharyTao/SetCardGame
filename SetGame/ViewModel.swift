//
//  ViewModel.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import Foundation
import SwiftUI


class ViewModel: ObservableObject{
    
    @Published private var model: SetGame
    
    init() {
        self.model = SetGame()
    }
    
    var cards: [Card]{
        model.cards
    }
    
    func dealMoreCard(){
        if model.cards.count < 81{
            model.dealMoreCard()
        }
    }
    
    func newGame(){
        model = SetGame()
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    var score: Int{
        model.score
    }
    


    
    
    

    
    
    
}

