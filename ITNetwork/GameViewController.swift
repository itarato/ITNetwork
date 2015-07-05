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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tapOccurred:"), name: ITNETWORK_EVENT_DID_TAP, object: nil)
    }
    
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
        
        for elem in self.graph.vertices {
            guard let v: Vertex = elem else {
                continue
            }
            
            let tileViewCtrl = v.elem as! TileViewController

            tileViewCtrl.server.hidden = v.type != .Source
            tileViewCtrl.computer.hidden = v.type != .Computer
            for dir in VertexConnectionDirecion.all() {
                if v.connections[dir.rawValue] {
                    tileViewCtrl.setConnection(dir)
                }
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tapOccurred(notification: NSNotification) {
        // Review the flow.
//        self.graph.reviewFlow()
    }
    
}
