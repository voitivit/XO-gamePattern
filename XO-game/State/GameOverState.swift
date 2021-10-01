//
//  GameOverState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 27.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameOverState: GameState {
    var isMoveCompleted = false
    
    public let winner: Player?
    
    weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        Log(action: .gameFinished(winner: winner))
        
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = getWinnerName(from: winner) + " won"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) { }
    
    
    func getWinnerName(from: Player) -> String {
        switch winner {
        case .first:
            if gameViewController?.gameType == GameType.vsPlayer {
                return "1st player"
            }
            return "Player"
        case .second:
            if gameViewController?.gameType == GameType.vsPlayer {
                return "2st player"
            }
            return "Computer"
        case .none:
            return "there is no winner"
        }
    }
    
}
