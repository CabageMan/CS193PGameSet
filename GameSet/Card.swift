//
//  Card.swift
//  GameSet
//
//  Created by ViktorsMacbook on 08.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

struct Card {
    /*
    // Iplementation of Hashable protocol
    var hashValue: Int 
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return ((lhs.symbolsNumber == rhs.symbolsNumber) ||
                (lhs.symbolsShape == rhs.symbolsShape) ||
                (lhs.symbolsColor == rhs.symbolsColor) ||
                (lhs.symbolsFilling == rhs.symbolsFilling))
    }
    */
    
    enum cardFeature {
        case symbolsNumber(cardFeatureVariants)
        case symbolsShape(cardFeatureVariants)
        case symbolsColor(cardFeatureVariants)
        case symbolsFilling(cardFeatureVariants)
    }
    
    enum cardFeatureVariants {
        case v1
        case v2
        case v3
        
        static var allVariants: [cardFeatureVariants]{
            return [.v1, .v2, .v3]
        }
    }
    
    // Declare properties
    let symbolsNumber: cardFeatureVariants
    let symbolsShape: cardFeatureVariants
    let symbolsColor: cardFeatureVariants
    let symbolsFilling: cardFeatureVariants
    
    var isSelected: Bool
    var isMatched: Bool
    
    init(number: cardFeatureVariants, shape: cardFeatureVariants, color: cardFeatureVariants, filling: cardFeatureVariants) {
        symbolsNumber = number
        symbolsShape = shape
        symbolsColor = color
        symbolsFilling = filling
        isSelected = false
        isMatched = false
    }
    
}
