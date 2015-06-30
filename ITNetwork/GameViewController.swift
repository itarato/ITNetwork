//
//  GameViewController.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    
    @IBOutlet weak var gridCanvas: UIView!
    
    var graph:Graph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        self.initializeGrid()
    }
    
    private func initializeGrid() {
        let width = GameConfiguration.globalConfiguration().width
        let height = GameConfiguration.globalConfiguration().height
        self.graph = Graph(w: width, h: height)
        
        let playFrameSize = self.gridCanvas.frame.size
        let tileSize = min(playFrameSize.height / CGFloat(height), playFrameSize.width / CGFloat(width))
        
        for var j = 0; j < height; j++ {
            for var i = 0; i < width; i++ {
                let tileFrame = CGRect(x: tileSize * CGFloat(i), y: tileSize * CGFloat(j), width: tileSize, height: tileSize)
                let tile = TileViewController()
                tile.view.frame = tileFrame
                self.gridCanvas.addSubview(tile.view)
                
                self.graph.setJI(j: j, i: i, v: Vertex(elem: tile))
            }
        }
        
        self.graph.makeNetwork()
        
        for v in self.graph.matrix {
            let tileViewCtrl = v!.elem as! TileViewController
            if v?.type == .Source {
                tileViewCtrl.server.hidden = false
            }
            if v?.type == .Computer {
                tileViewCtrl.computer.hidden = false
            }
            if v!.connections[VertexConnectionDirecion.Down.indexOf()] {
                tileViewCtrl.connectionDown.hidden = false
            }
            if v!.connections[VertexConnectionDirecion.Up.indexOf()] {
                tileViewCtrl.connectionUp.hidden = false
            }
            if v!.connections[VertexConnectionDirecion.Left.indexOf()] {
                tileViewCtrl.connectionLeft.hidden = false
            }
            if v!.connections[VertexConnectionDirecion.Right.indexOf()] {
                tileViewCtrl.connectionRight.hidden = false
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
