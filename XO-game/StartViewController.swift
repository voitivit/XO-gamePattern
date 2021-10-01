//
//  StartViewController.swift
//  XO-game
//
//  Created by emil kurbanov on 01.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//


import UIKit
enum GameType {
    case vsComputer, vsPlayer, vsPlayerMoves
}

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func gameType(_ sender: UIButton) {
        guard let mainStoryboard = storyboard else { fatalError() }
        guard let gameViewController = mainStoryboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController else { fatalError() }
        
        switch sender.tag {
        case 0:
            gameViewController.gameType = .vsPlayerMoves
        case 1:
            gameViewController.gameType = .vsComputer
        default:
            gameViewController.gameType = .vsPlayer
        }
        
        show(gameViewController, sender: nil)
    }
    }
