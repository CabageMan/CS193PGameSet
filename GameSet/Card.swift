//
//  Card.swift
//  GameSet
//
//  Created by ViktorsMacbook on 08.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

struct Card: Equatable{
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return ((lhs.symbolsNumber == rhs.symbolsNumber) &&
                (lhs.symbolsShape == rhs.symbolsShape) &&
                (lhs.symbolsColor == rhs.symbolsColor) &&
                (lhs.symbolsFilling == rhs.symbolsFilling))
    }
    
    enum cardFeatureVariants: Int {
        case v1 = 1
        case v2
        case v3
        
        static var allVariants: [cardFeatureVariants]{
            return [.v1, .v2, .v3]
        }
        var index: Int {
            return self.rawValue - 1
        }
    }
    
    // Declare properties
    let symbolsNumber: cardFeatureVariants
    let symbolsShape: cardFeatureVariants
    let symbolsColor: cardFeatureVariants
    let symbolsFilling: cardFeatureVariants
    
    init(number: cardFeatureVariants, shape: cardFeatureVariants, color: cardFeatureVariants, filling: cardFeatureVariants) {
        symbolsNumber = number
        symbolsShape = shape
        symbolsColor = color
        symbolsFilling = filling
    }
    
}
