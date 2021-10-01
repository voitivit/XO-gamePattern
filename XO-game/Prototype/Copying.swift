//
//  Copying.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 27.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol Copying: AnyObject {
    init(_ prototype: Self)
}

extension Copying where Self: AnyObject {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
