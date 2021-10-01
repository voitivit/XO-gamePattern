//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var gameType: GameType = .vsPlayer
    
    private let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    private var counter: Int = 0
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                self.counter += 1
                self.setNextState()
            }
        }
    }
    private func setFirstState() {
        let player = Player.first
        
        if gameType == .vsPlayer {
            firstPlayerTurnLabel.text = "1st player"
            secondPlayerTurnLabel.text = "2nd player"
            
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        } else if gameType == .vsPlayerMoves {
            firstPlayerTurnLabel.text = "1st player"
            secondPlayerTurnLabel.text = "2nd player"
            
            currentState = PlayerMovesState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        } else {
            firstPlayerTurnLabel.text = "Player"
            secondPlayerTurnLabel.text = "Computer"
            
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        }

    }
    
    private func setNextState() {
        if gameType == .vsPlayerMoves {
            if counter <= 1 {
                if let playerInputState = currentState as? PlayerMovesState {
                    gameboardView.clear()
                    gameBoard.clear()
                    
                    let player = playerInputState.player.next
                    currentState = PlayerMovesState(player: playerInputState.player.next, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView,
                                               markViewPrototype: player.markViewPrototype)
                }
            } else {
                currentState = PlayerExecuteState(winner: nil, gameViewController: self)
            }
        } else {
            if let winner = referee.determineWinner() {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            }
            
            if counter >= 9 {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
            
            if(gameType == .vsPlayer) {
                if let playerInputState = currentState as? PlayerState {
                    let player = playerInputState.player.next
                    currentState = PlayerState(player: playerInputState.player.next, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView,
                                               markViewPrototype: player.markViewPrototype)
                }
            } else {
                if(counter % 2 == 0) {
                    let player = Player.first
                    currentState = PlayerState(player: player, gameViewController: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView,
                                               markViewPrototype: player.markViewPrototype)
                    
                } else {
                    let player = Player.second
                    currentState = ComputerState(player: player, gameViewController: self,
                                                      gameBoard: gameBoard, gameBoardView: gameboardView,
                                                      markViewPrototype: player.markViewPrototype)
                }
            }
        }
        
    }
    
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
        counter = 0
    }
    
    
    
    @IBAction func showStartMenu(_ sender: UIButton) {
        guard let startViewController = storyboard?.instantiateViewController(withIdentifier: "startViewController") as? StartViewController else { fatalError() }
        
        show(startViewController, sender: nil)
    }
    }


