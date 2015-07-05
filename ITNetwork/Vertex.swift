//
//  Vertex.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

class Vertex {

    let elem: ITNetworkNode
    
    var type: VertexType = .Empty
    
    var parent: Vertex?
    
    var connections: [Bool] = [
        false, // Up
        false, // Right
        false, // Down
        false, // Left
    ]
    
    var color: VertexColor = .White
    
    init(elem: ITNetworkNode) {
        self.elem = elem
        self.elem.vertex = self
    }
    
    deinit {
        self.parent = nil
    }
    
    func rotateLeft() {
        self.connections.rotateLeft()
    }
    
    func rotateRight() {
        self.connections.rotateRight()
    }
    
}
