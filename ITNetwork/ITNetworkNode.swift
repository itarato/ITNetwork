//
//  VertexAware.swift
//  ITNetwork
//
//  Created by Peter Arato on 01/07/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

protocol ITNetworkNode {
    
    var vertex: Vertex? { get set }
    
    func setComputer()
    
    func setServer()
    
    func setConnection(direction: VertexConnectionDirecion)
    
    func setAvailability(onOff: Bool)
    
}
