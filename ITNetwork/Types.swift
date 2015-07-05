//
//  Types.swift
//  ITNetwork
//
//  Created by Peter Arato on 05/07/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

struct Point {
    var j: Int = 0
    var i: Int = 0
}

struct NeighbourPoint {
    var p: Point
    var dir: VertexConnectionDirecion
    init(j: Int, i: Int, dir: VertexConnectionDirecion) {
        self.p = Point(j: j, i: i)
        self.dir = dir
    }
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
    
    static func all() -> [VertexConnectionDirecion] {
        return [.Up, .Right, .Down, .Left]
    }
}
