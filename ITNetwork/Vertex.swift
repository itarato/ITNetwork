//
//  Vertex.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

enum VertexType {
    case Empty
    case Source
    case Computer
}

enum VertexColor {
    case White
    case Grey
    case Black
}

enum VertexConnectionDirecion {
    case Up
    case Right
    case Down
    case Left
    
    func opposite() -> VertexConnectionDirecion {
        switch self {
        case Up: return .Down
        case Right: return .Left
        case Down: return .Up
        case Left: return .Right
        }
    }
    
    func indexOf() -> Int {
        switch self {
        case Up: return 0
        case Right: return 1
        case Down: return 2
        case Left: return 3
        }
    }
}

class Vertex {

    let elem: AnyObject
    
    var type: VertexType = .Empty
    
    var parent: Vertex?
    
    var connections: [Bool] = [
        false, // Up
        false, // Right
        false, // Down
        false, // Left
    ]
    
    var color: VertexColor = .White
    
    init(elem: AnyObject) {
        self.elem = elem
    }
    
}
