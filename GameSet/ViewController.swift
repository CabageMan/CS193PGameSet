//
//  ViewController.swift
//  GameSet
//
//  Created by ViktorsMacbook on 07.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import UIKit

extension String {
    func getCharacterAt(index i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    private lazy var game = GameSet()
    
    var figureChoices = "○□▵"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(figureChoices.getCharacterAt(index: 0))
        
        for card in game.cardsDeck {
            print("Numbers: \(card.symbolsNumber), Shape: \(card.symbolsShape), Color: \(card.symbolsColor), Filling: \(card.symbolsFilling)")
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCardIndex = cardButtons.index(of: sender) {
            game.deal3Cards(times: 27)
            print("\\\\\\\\\\\\\\\\\\\\\\")
            for card in game.cardsOnTable {
                print("Numbers: \(card.symbolsNumber), Shape: \(card.symbolsShape), Color: \(card.symbolsColor), Filling: \(card.symbolsFilling)")
            }
            print("Cards in deck: \(game.cardsDeck.count), Cards on table: \(game.cardsOnTable.count)")
        } else {
            print("Choosen card not found")
        }
    }
    
    
}

