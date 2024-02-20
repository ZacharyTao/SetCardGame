//
//  AspectGrid.swift
//  SetGame
//
//  Created by Zachary Tao on 2/18/24.
//

import SwiftUI

struct AspectGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content : (Item) -> ItemView
    var body: some View {
        GeometryReader{ geometry in
            let gridSize = gridItemWidthThatFits(count: items.count, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize), spacing: 0)], spacing: 0) {
                ForEach(items){ item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fill)

                }
                
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat{
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height{
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        }while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

