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
    @IBOutlet weak var configRows: UILabel!
    @IBOutlet weak var configCols: UILabel!
    @IBOutlet weak var plusMinusRows: UIStepper!
    @IBOutlet weak var plusMinusCols: UIStepper!
    
    var graph:Graph!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tapOccurred:"), name: ITNETWORK_EVENT_DID_TAP, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plusMinusCols.value = Double(GameConfiguration.globalConfiguration().width)
        self.plusMinusRows.value = Double(GameConfiguration.globalConfiguration().height)
        self.refreshConfigDisplay()
    }
    
    private func refreshConfigDisplay() {
        self.configRows.text = String(format: "%0.0f", self.plusMinusRows.value)
        self.configCols.text = String(format: "%0.0f", self.plusMinusCols.value)
    }
    
    private func initializeGrid() {
        let width = GameConfiguration.globalConfiguration().width
        let height = GameConfiguration.globalConfiguration().height
        self.graph = Graph(w: width, h: height)
        
        let playFrameSize = self.gridCanvas.frame.size
        var tileSize = min(playFrameSize.height / CGFloat(height), playFrameSize.width / CGFloat(width))
        tileSize = tileSize - (tileSize % 2)
        let paddingLeft = (playFrameSize.width - tileSize * CGFloat(width)) * 0.5
        let paddingTop = (playFrameSize.height - tileSize * CGFloat(height)) * 0.5
        
        for var j = 0; j < height; j++ {
            for var i = 0; i < width; i++ {
                let tileFrame = CGRect(x: paddingLeft + tileSize * CGFloat(i), y: paddingTop + tileSize * CGFloat(j), width: tileSize, height: tileSize)
                let tile = TileViewController(nibName: "TileView", bundle: nil)
                tile.view.frame = tileFrame
                self.gridCanvas.addSubview(tile.view)
                
                self.graph.setJI(Point(j: j, i: i), v: Vertex(elem: tile))
            }
        }
        
        self.graph.makeNetwork()
        
        for elem in self.graph.vertices {
            guard let v: Vertex = elem else {
                continue
            }
            
            let tileViewCtrl = v.elem as! TileViewController

            if v.type == .Source {
                tileViewCtrl.setServer()
            }
            if v.type == .Computer {
                tileViewCtrl.setComputer()
            }
            for dir in VertexConnectionDirecion.all() {
                if v.connections[dir.rawValue] {
                    tileViewCtrl.setConnection(dir)
                }
            }
        }
        
        self.graph.randomize()
        
        self.graph.reviewFlow()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tapOccurred(notification: NSNotification) {
        self.graph.reviewFlow()
    }
    
    @IBAction func onHitGo() {
        for subview in self.gridCanvas.subviews {
            subview.removeFromSuperview()
        }
        self.initializeGrid()
    }
    
    @IBAction func ohHitConfigRows() {
        GameConfiguration.globalConfiguration().height = Int(self.plusMinusRows.value)
        self.refreshConfigDisplay()
    }
    
    @IBAction func onHitConfigCols() {
        GameConfiguration.globalConfiguration().width = Int(self.plusMinusCols.value)
        self.refreshConfigDisplay()
    }
    
}
