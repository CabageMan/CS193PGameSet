//
//  ViewController.swift
//  GameSet
//
//  Created by ViktorsMacbook on 07.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    private lazy var game = GameSet()
    private var cardsFigures = [Card : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(game.cardsDeck.count)
        
        for card in game.cardsDeck {
            print("Numbers: \(card.symbolsNumber), Shape: \(card.symbolsShape), Color: \(card.symbolsColor), Filling: \(card.symbolsFilling)")
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCardIndex = cardButtons.index(of: sender) {
            updateViewByModel()
            print("The index of choosen card is \(touchedCardIndex)")
        } else {
            print("Choosen card not found")
        }
    }
    
    private func updateViewByModel() {
        print("Yes, tups are worked")
    }
    
}

