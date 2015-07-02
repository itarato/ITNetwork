//
//  Vertex.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

struct Point {
    var j: Int = 0
    var i: Int = 0
}

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

enum VertexConnectionDirecion: Int {
    case Up = 0, Right, Down, Left
    
    func opposite() -> VertexConnectionDirecion {
        switch self {
        case .Up: return .Down
        case .Right: return .Left
        case .Down: return .Up
        case .Left: return .Right
        }
    }
    
    func neighbour() -> Point {
        switch self {
        case .Up: return Point(j: -1, i: 0)
        case .Right: return Point(j: 0, i: 1)
        case .Down: return Point(j: 1, i: 0)
        case .Left: return Point(j: 0, i: -1)
        }
    }
}

class Vertex {

    let elem: VertexAware
    
    var type: VertexType = .Empty
    
    var parent: Vertex?
    
    var connections: [Bool] = [
        false, // Up
        false, // Right
        false, // Down
        false, // Left
    ]
    
    var color: VertexColor = .White
    
    init(elem: VertexAware) {
        self.elem = elem
        self.elem.vertex = self
    }
    
    func rotateLeft() {
        self.connections.rotateLeft()
    }
    
    func rotateRight() {
        self.connections.rotateRight()
    }
    
}
