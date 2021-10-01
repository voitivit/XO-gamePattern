//
//  PlayerInvoker.swift
//  XO-game
//
//  Created by emil kurbanov on 01.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerInvoker {
    
    public static let shared = PlayerInvoker()
    
    private var commands: [PlayerCommand] = []
    
    func addPlayerCommand(command: PlayerCommand) {
        commands.append(command)
    }
    
    public func execute() {
        let commandsPool = PlayerInvoker.shared.commands
        
        for i in 0..<commandsPool.count/2 {
            let delay = Double(i + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                commandsPool[i].execute()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.5) {
                commandsPool[i + commandsPool.count/2].execute()
            }
        }
        commands = []
    }
    
}
