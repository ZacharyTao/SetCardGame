//
//  SetGameView.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var viewModel : ViewModel = ViewModel()
    private let cardAspectRatio: CGFloat = 2.3/3
    var body: some View {
        VStack(spacing: 0){
            HStack{
                newGameButton
                    .padding(.horizontal)
                Spacer()
                moreCardButton.font(.title)
                    .padding(.horizontal)
            }
            cards
                .animation(.easeInOut(duration: 0.2), value: viewModel.cards)
                .padding(5)
            Text("Score: \(viewModel.score)")
                .font(.title)
                .fontWeight(.bold)
        }.padding(3)
        
    }
    
    @ViewBuilder
    var moreCardButton: some View{
        if viewModel.cards.count > 15{
            Image(systemName: "plus.square.on.square")
                .fontWeight(.bold)
        }else{
            Button{
                viewModel.dealMoreCard()
            }label: {
                Image(systemName: "plus.square.on.square")
                    .fontWeight(.bold)
            }
        }
        
    }
    
    var newGameButton: some View{
        Button{
            viewModel.newGame()
        }label: {
            Text("New Game")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            
        }
    }
    
    var cards: some View {
        AspectGrid(items: viewModel.cards, aspectRatio: cardAspectRatio){card in
            CardView(card: card)
                .aspectRatio(cardAspectRatio, contentMode: .fill)
                .padding(6)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}


struct CardView: View{
    let card: Card
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                let base = RoundedRectangle(cornerRadius: 15)
                Group{
                    if card.isNotMatched{
                        base.fill(.white)
                        base.fill(Color.red)
                            .opacity(0.2)
                        base.stroke(.red, lineWidth: 5)
                    }else if card.isChosen {
                        base.fill(Color.yellow)
                        base.stroke(.black, lineWidth: 4)

                    } else {
                        base.stroke(.black, lineWidth: 6)
                        base.fill(Color.white)
                    }
                    
                    
                    VStack{
                        ForEach(0..<getNumber(of: card.number), id: \.self){_ in
                            getContent(card, geometry: geometry.size)
                            
                        }
                    }.padding(.horizontal, 3)
                    
                }
            }
        }.scaleEffect(card.isChosen ? 1.04 : 1.0)
    }
    
}

#Preview {
    SetGameView(viewModel: ViewModel())
}

func getContent(_ card: Card, geometry: CGSize) -> AnyView{
    switch card.shading {
    case .solid:
        AnyView(
            getShape(of: card.shape, strokeColor: getColor(of: card.color), fillColor: getColor(of: card.color))
                .frame(width: geometry.width * 0.7, height: geometry.height/5)
        )
    case .striped:
        AnyView(
            getStripedShape(of: card.shape, color: getColor(of: card.color))
                .frame(width: geometry.width * 0.7, height: geometry.height/5)
                    .foregroundColor(getColor(of: card.color))
        )
    case .open:
        AnyView(
            getShape(of: card.shape, strokeColor: getColor(of: card.color), fillColor: .clear)
                .frame(width: geometry.width * 0.7, height: geometry.height/5)
        )
    }
}


func getColor(of color: CardColor) -> Color{
    switch color{
    case CardColor.green:
        return Color.vibrantCoral
    case CardColor.purple:
        return Color.deepBlue
    case CardColor.red:
        return Color.softMint
    }
}

func getNumber(of num: CardNumber) -> Int{
    switch num{
    case .one:
        return 1
    case .two:
        return 2
    case .three:
        return 3
    }
}

func getShape(of shape: CardShape, strokeColor: Color, fillColor: Color) -> some View{
    Group{
        switch shape{
        case .diamond:
            Diamond()
                .stroke(strokeColor, lineWidth: 6)
                .fill(fillColor)

        case .squiggle:
            Squiggle()
                .fill(fillColor)
                .stroke(strokeColor, lineWidth: 6)
        case .oval:
            RoundedRectangle(cornerRadius: 15)
                .fill(fillColor)
                .stroke(strokeColor, lineWidth: 6)
        }
    }
}

func getStripedShape(of shape: CardShape, color: Color) -> some View{
    Group{
        switch shape{
        case .diamond:
            Diamond()
                .striped(color: color)

        case .squiggle:
            Squiggle()
                .striped(color: color)
        case .oval:
            RoundedRectangle(cornerRadius: 15)
                .striped(color: color)

        }
    }
}


extension Shape {

    func striped(color: Color) -> some View {
        ZStack {
            self.stroke(color, lineWidth: 6)
            HStack(spacing: 0) {
                ForEach(0..<12, id: \.self) { number in
                    Spacer(minLength: 0)
                    color.frame(width: 3)
                }
            }.mask(self)
            
        }
    }
}

extension Color {
    static let deepBlue = Color(red: 0.0, green: 0.0, blue: 0.5)
    static let vibrantCoral = Color(red: 1.0, green: 0.5, blue: 0.31)
    static let softMint = Color(red: 0.47, green: 0.87, blue: 0.47)
    static let alertRed = Color(red: 0.85, green: 0, blue: 0.3)}
