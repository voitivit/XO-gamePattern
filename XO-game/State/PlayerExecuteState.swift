//
//  PlayerExecuteState.swift
//  XO-game
//
//  Created by emil kurbanov on 01.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation
class PlayerExecuteState: GameState {
    var isMoveCompleted = false
    
    public let winner: Player?
    
    weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        
        PlayerInvoker.shared.execute()
 
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
