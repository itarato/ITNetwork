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
    
    func getJI(j j: Int, i: Int) -> Vertex? {
        if j < 0 || i < 0 || j >= self.h || i >= self.w {
            return nil
        }
        return self.vertices[j * w + i]
    }

    func setJI(j j: Int, i: Int, v: Vertex) {
        if j < 0 || i < 0 || j >= self.h || i >= self.w {
            return
        }
        self.vertices[j * w + i] = v
    }
    
    func makeNetwork() {
        let randJ = RandomUtil.randIntRange(0, to: self.h)
        let randI = RandomUtil.randIntRange(0, to: self.w)
        self.serverPos = Point(j: randJ, i: randI)
        let server: Vertex! = self.getJI(j: randJ, i: randI)
        server?.type = .Source
        server?.color = .Grey
        
        let queue = Queue<Point>()
        
        var serverConnections = [NeighbourPoint]()
        for pos in self.neighbourMap {
            serverConnections.append(NeighbourPoint(j: randJ + pos.neighbour().j, i: randI + pos.neighbour().i, dir: pos))
        }
        let initialConnections = self.createRandomConnections(from: server, to: serverConnections)
        for item in initialConnections {
            queue.add(item)
        }

        while let p = queue.get() {
            guard let v = self.getJI(j: p.j, i: p.i) else {
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
            if let neighbour = self.getJI(j: p.j + pos.neighbour().j, i: p.i + pos.neighbour().i) {
                if neighbour.color == .White {
                    neighbours.append(NeighbourPoint(j: p.j + pos.neighbour().j, i: p.i + pos.neighbour().i, dir: pos))
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
        guard let toVertex = self.getJI(j: to.p.j, i: to.p.i) else {
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
