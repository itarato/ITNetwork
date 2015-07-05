//
//  GameConfiguration.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

class GameConfiguration {
    
    static private var globalConfig: GameConfiguration!
    
    var width: Int
    var height: Int
    
    static func globalConfiguration() -> GameConfiguration {
        if GameConfiguration.globalConfig == nil {
            GameConfiguration.globalConfig = GameConfiguration()
        }
        return GameConfiguration.globalConfig
    }
    
    init(width: Int = 6, height: Int = 8) {
        self.width = width
        self.height = height
    }
    
}
