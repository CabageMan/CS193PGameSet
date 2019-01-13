//
//  ViewController.swift
//  GameSet
//
//  Created by ViktorsMacbook on 07.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import UIKit

extension String {
    func join(number: Int, with separator: String) -> String {
        guard number > 1 else {
            return self
        }
        var symbols = [String]()
        for _ in 0..<number {
            symbols += [self]
        }
        return symbols.joined(separator: separator)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    private lazy var game = GameSet()
    
    struct DefaultButton {
        static let borderWidth: CGFloat = 0.0
        static let cornerRadius: CGFloat = 8.0
        static let borderColor = UIColor.white.cgColor
    }
    
    struct SelectedButton {
        static let borderWidth: CGFloat = 3.0
        static let cornerRadius: CGFloat = 6.0
        static let borderColor = UIColor.blue.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStart()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: touchedCardIndex)
            updateViewFromModel()
        } else {
            print("Choosen card not found")
        }
    }
    
    func gameStart() {
        game = GameSet()
        game.deal3Cards(times: 4)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in game.cardsOnTable.indices {
            let card = game.cardsOnTable[index]
            let button = cardButtons[index]
            
            if game.selectedCards.contains(card) {
                markButtonAsSelected(button: button)
            } else {
                markButtonAsUnselected(button: button)
            }
            
            drawCard(card: card, on: button)
        }
    }
    
    func drawCard(card: Card, on button: UIButton) {
        let figureShapes = ["●", "▲", "■"]
        let figureColors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
        let figureStrokeWidth: [CGFloat] = [-8, 8, -8]
        let figureAlphas: [CGFloat] = [1.0, 0.4, 0.23]
        
        // Create string
        let shape = figureShapes[card.symbolsShape.index]
        let figureSeparator = card.symbolsNumber.rawValue > 1 ? "\n" : ""
        let buttonIconString = shape.join(number: card.symbolsNumber.rawValue, with: figureSeparator)
        
        // Create attributes
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeColor: figureColors[card.symbolsColor.index],
            .strokeWidth: figureStrokeWidth[card.symbolsFilling.index],
            .foregroundColor: figureColors[card.symbolsColor.index].withAlphaComponent(figureAlphas[card.symbolsFilling.index])
        ]
        
        // Set attributed button's title
        button.setAttributedTitle(NSAttributedString(string: buttonIconString, attributes: attributes), for: .normal)
    }
    
    func markButtonAsSelected(button: UIButton) {
        button.layer.borderWidth = SelectedButton.borderWidth
        button.layer.borderColor = SelectedButton.borderColor
        button.layer.cornerRadius = SelectedButton.cornerRadius
    }
    
    func markButtonAsUnselected(button: UIButton) {
        button.layer.borderWidth = DefaultButton.borderWidth
        button.layer.borderColor = DefaultButton.borderColor
        button.layer.cornerRadius = DefaultButton.cornerRadius
    }
    
}

