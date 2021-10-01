//
//  PlayerCommand.swift
//  XO-game
//
//  Created by emil kurbanov on 01.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation
class PlayerCommand {
    
    let player: Player
    let gameBoardPosition: GameboardPosition
    let gameBoardView: GameboardView
    let gameBoard: Gameboard
    
    init(player: Player, gameBoardPosition: GameboardPosition, gameBoardView: GameboardView, gameBoard: Gameboard) {
        self.player = player
        self.gameBoardPosition = gameBoardPosition
        self.gameBoardView = gameBoardView
        self.gameBoard = gameBoard
    }
    
    func execute() {
        Log(action: .playerSetMark(player: player, position: gameBoardPosition))
        
        if gameBoardView.canPlaceMarkView(at: gameBoardPosition) {
            gameBoard.setPlayer(player, at: gameBoardPosition)
            gameBoardView.placeMarkView(player.markViewPrototype, at: gameBoardPosition)
        } else {
            gameBoard.setPlayer(player, at: gameBoardPosition)
            gameBoardView.removeMarkView(at: gameBoardPosition)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gameBoardView.placeMarkView(self.player.markViewPrototype, at: self.gameBoardPosition)
            }
            
        }
    }
    
}
