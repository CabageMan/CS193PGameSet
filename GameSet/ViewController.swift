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
    
    struct Constants {
        // Default button
        static let defaultBorderWidth: CGFloat = 0.0
        static let defaultCornerRadius: CGFloat = 8.0
        static let defaultBorderColor = UIColor.white.cgColor
        // Selected button
        static let selectedBorderWidth: CGFloat = 3.0
        static let selectedCornerRadius: CGFloat = 6.0
        static let selectedBorderColor = UIColor.blue.cgColor
        // Figures constant
        static let figureShapes = ["●", "▲", "■"]
        static let figureColors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
        static let figureStrokeWidth: [CGFloat] = [-8, 8, -8]
        static let figureAlphas: [CGFloat] = [1.0, 0.4, 0.23]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStart()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: touchedCardIndex)
            updateViewFromModel()
            print("Index of card: \(touchedCardIndex)")
        } else {
            print("Choosen card not found")
        }
    }
    
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        game.deal3Cards(times: 1)
        updateViewFromModel()
    }
    
    func gameStart() {
        game = GameSet()
        game.deal3Cards(times: 4)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            // Display only on table cards
            if game.cardsOnTable.indices.contains(index) {
                let card = game.cardsOnTable[index]
                
                if game.selectedCards.contains(card) {
                    markButtonAsSelected(button: button)
                } else {
                    markButtonAsUnselected(button: button)
                }
                
                drawCard(card: card, on: button)
            } else {
                // Hide and disable button
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.isEnabled = false
                // It must be attributed title
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    func drawCard(card: Card, on button: UIButton) {
        // Create string
        let shape = Constants.figureShapes[card.symbolsShape.index]
        let figureSeparator = card.symbolsNumber.rawValue > 1 ? "\n" : ""
        let buttonIconString = shape.join(number: card.symbolsNumber.rawValue, with: figureSeparator)
        
        // Create attributes
        let attributes: [NSAttributedStringKey : Any] = [
            .strokeColor: Constants.figureColors[card.symbolsColor.index],
            .strokeWidth: Constants.figureStrokeWidth[card.symbolsFilling.index],
            .foregroundColor: Constants.figureColors[card.symbolsColor.index].withAlphaComponent(Constants.figureAlphas[card.symbolsFilling.index])
        ]
        
        // Enable button and set it's attributed title
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.isEnabled = true
        button.setAttributedTitle(NSAttributedString(string: buttonIconString, attributes: attributes), for: .normal)
    }
    
    func markButtonAsSelected(button: UIButton) {
        button.layer.borderWidth = Constants.selectedBorderWidth
        button.layer.borderColor = Constants.selectedBorderColor
        button.layer.cornerRadius = Constants.selectedCornerRadius
    }
    
    func markButtonAsUnselected(button: UIButton) {
        button.layer.borderWidth = Constants.defaultBorderWidth
        button.layer.borderColor = Constants.defaultBorderColor
        button.layer.cornerRadius = Constants.defaultCornerRadius
    }
    
}

