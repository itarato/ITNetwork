//
//  Graph.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import Foundation

typealias NeighbourPos = (Int, Int, VertexConnectionDirecion)

class Graph {
    
    let w: Int
    let h: Int
    
    var matrix: [Vertex?]
    
    let neighbourMap:[NeighbourPos] = [
        (-1, 0, VertexConnectionDirecion.Up),
        (0, 1, VertexConnectionDirecion.Right),
        (1, 0, VertexConnectionDirecion.Down),
        (0, -1, VertexConnectionDirecion.Left),
    ]
    
    init(w: Int, h: Int) {
        self.w = w
        self.h = h
        
        self.matrix = [Vertex?](count: h * w, repeatedValue: nil)
    }
    
    func getJI(j j: Int, i: Int) -> Vertex? {
        if j < 0 || i < 0 || j >= self.h || i >= self.w {
            return nil
        }
        return self.matrix[j * w + i]
    }

    func setJI(j j: Int, i: Int, v: Vertex) {
        if j < 0 || i < 0 || j >= self.h || i >= self.w {
            return
        }
        self.matrix[j * w + i] = v
    }
    
    func makeNetwork() {
        let randJ = RandomUtil.randIntRange(0, to: self.h)
        let randI = RandomUtil.randIntRange(0, to: self.w)
        let server: Vertex! = self.getJI(j: randJ, i: randI)
        server?.type = .Source
        server?.color = .Grey
        
        let queue = Queue<NeighbourPos>()
        // @Todo don't forget to make connections from the server and only use those ones
        
        var serverConnections = [NeighbourPos]()
        for pos in self.neighbourMap {
            serverConnections.append((randJ + pos.0, randI + pos.1, pos.2))
        }
        let initialConnections = self.createConnections(from: server, to: serverConnections)
        for item in initialConnections {
            queue.add(item)
        }

        while let (j, i, _) = queue.get() {
            guard let v = self.getJI(j: j, i: i) else {
                continue
            }
            
            v.color = .Grey
            
            // This is empty
            // Decide if computer / empty (maybe not) / connection
            let neighbours = self.getWhiteNeighbours(j: j, i: i)
            if neighbours.count == 0 {
                v.type = .Computer
            } else {
                let randChoice = RandomUtil.randIntRange(0, to: 10)
                if randChoice < 3 {
                    v.type = .Computer
                } else {
                    let connected = self.createConnections(from: v, to: neighbours)
                    // @todo try shuffling it
                    for connectedPos in connected {
                        queue.add(connectedPos)
                    }
                }
            }
            
            v.color = .Black
        }
    }
    
    func getWhiteNeighbours(j j: Int, i: Int) -> [NeighbourPos] {
        var neighbours = [NeighbourPos]()
        for pos in self.neighbourMap {
            if let neighbour = self.getJI(j: j + pos.0, i: i + pos.1) {
                if neighbour.color == .White {
                    neighbours.append((j + pos.0, i + pos.1, pos.2))
                }
            }
        }
        return neighbours
    }
    
    func createConnections(from from: Vertex, to: [NeighbourPos]) -> [NeighbourPos] {
        var connected = [NeighbourPos]()
        let fixed = RandomUtil.randIntRange(0, to: to.count)
        for var i = 0; i < to.count; i++ {
            if i == fixed || RandomUtil.randIntRange(0, to: 10) < 8 {
                if makeConnection(from: from, to: to[i]) {
                    connected.append(to[i])
                }
            }
        }
        return connected
    }
    
    func makeConnection(from from: Vertex, to: NeighbourPos) -> Bool {
        guard let toVertex = self.getJI(j: to.0, i: to.1) else {
            return false
        }
        
        let fromConnectionIDX = to.2.indexOf()
        let toConnectionIDX = to.2.opposite().indexOf()
        
        from.connections[fromConnectionIDX] = true
        toVertex.connections[toConnectionIDX] = true
        
        toVertex.color = .Grey
        
        return true
    }
    
}
