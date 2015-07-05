//
//  Graph.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import Foundation

class Graph {
    
    let w: Int
    let h: Int
    
    var vertices: [Vertex?]
    
    var serverPos: Point?
    
    let neighbourMap:[VertexConnectionDirecion] = [
        VertexConnectionDirecion.Up,
        VertexConnectionDirecion.Right,
        VertexConnectionDirecion.Down,
        VertexConnectionDirecion.Left,
    ]
    
    init(w: Int, h: Int) {
        self.w = w
        self.h = h
        
        self.vertices = [Vertex?](count: h * w, repeatedValue: nil)
    }
    
    func getJI(p: Point) -> Vertex? {
        if p.j < 0 || p.i < 0 || p.j >= self.h || p.i >= self.w {
            return nil
        }
        return self.vertices[p.j * w + p.i]
    }

    func setJI(p: Point, v: Vertex) {
        if p.j < 0 || p.i < 0 || p.j >= self.h || p.i >= self.w {
            return
        }
        self.vertices[p.j * w + p.i] = v
    }
    
    func makeNetwork() {
        self.serverPos = Point(j: RandomUtil.randIntRange(0, to: self.h), i: RandomUtil.randIntRange(0, to: self.w))
        let server: Vertex! = self.getJI(self.serverPos!)
        server?.type = .Source
        server?.color = .Grey
        
        let queue = Queue<Point>()
        
        var serverConnections = [NeighbourPoint]()
        for pos in self.neighbourMap {
            serverConnections.append(NeighbourPoint(p: self.serverPos! + pos.neighbour(), dir: pos))
        }
        let initialConnections = self.createRandomConnections(from: server, to: serverConnections)
        for item in initialConnections {
            queue.add(item)
        }

        while let p = queue.get() {
            guard let v = self.getJI(p) else {
                continue
            }
            
            v.color = .Grey
            
            // This is empty
            // Decide if computer / connection
            let neighbours = self.getWhiteNeighbours(p)
            if neighbours.count == 0 {
                v.type = .Computer
            } else {
                let randChoice = RandomUtil.randIntRange(0, to: 10)
                if randChoice < 3 {
                    v.type = .Computer
                } else {
                    let connected = self.createRandomConnections(from: v, to: neighbours)
                    for connectedPos in connected {
                        queue.add(connectedPos)
                    }
                }
            }
            
            v.color = .Black
        }
    }
    
    func getWhiteNeighbours(p: Point) -> [NeighbourPoint] {
        var neighbours = [NeighbourPoint]()
        for pos in self.neighbourMap {
            if let neighbour = self.getJI(p + pos.neighbour()) {
                if neighbour.color == .White {
                    neighbours.append(NeighbourPoint(p: p + pos.neighbour(), dir: pos))
                }
            }
        }
        return neighbours
    }
    
    func createRandomConnections(from from: Vertex, to: [NeighbourPoint]) -> [Point] {
        var connected = [Point]()
        let fixed = RandomUtil.randIntRange(0, to: to.count)
        for var i = 0; i < to.count; i++ {
            if i == fixed || RandomUtil.randIntRange(0, to: 10) < 8 {
                if makeConnection(from: from, to: to[i]) {
                    connected.append(to[i].p)
                }
            }
        }
        return connected
    }
    
    func makeConnection(from from: Vertex, to: NeighbourPoint) -> Bool {
        guard let toVertex = self.getJI(to.p) else {
            return false
        }
        
        let fromConnectionIDX = to.dir.rawValue
        let toConnectionIDX = to.dir.opposite().rawValue
        
        from.connections[fromConnectionIDX] = true
        toVertex.connections[toConnectionIDX] = true
        
        toVertex.color = .Grey
        
        return true
    }
    
//    func reviewFlow() {
//        for v in self.matrix {
//            v?.color = .White
//            let tile = v!.elem as! TileViewController
//            tile.turnOnAvailability(false)
//        }
//
//        let queue = Queue<Point>()
//        queue.add(self.serverPos!)
//
//        while let pos = queue.get() {
//            guard let v = self.getJI(j: pos.j, i: pos.i) else {
//                continue
//            }
//            
//            v.color = .Grey
//            
////            if
//            
//            v.color = .Black
//        }
//    }
//    
//    func isConnected(v:Vertex, pos: Point, dir:VertexConnectionDirecion) -> Point? {
//        
//    }
//    
}
