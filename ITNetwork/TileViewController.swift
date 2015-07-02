//
//  TileViewController.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import UIKit

class TileViewController : UIViewController, VertexAware {
    
    @IBOutlet weak var server: UILabel!
    @IBOutlet weak var computer: UILabel!
    @IBOutlet weak var onOff: UILabel!
    
    @IBOutlet weak var connectionView: UIView!
    
    var delegate: TileTapReceiver?
    
    var vertex: Vertex?
    
    init() {
        super.init(nibName: "TileView", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.computer.hidden = true
        self.server.hidden = true
        self.onOff.hidden = true
    }
    
    @IBAction func onTap(sender: AnyObject) {
        self.delegate?.tapOccurredFrom(self)
        self.vertex?.rotateRight()
        UIView.animateWithDuration(0.2) { () -> Void in
            self.connectionView.transform = CGAffineTransformRotate(self.connectionView.transform, CGFloat(M_PI / 2))
        }
    }
    
    func turnOnConnection(direction: VertexConnectionDirecion) {
        let frame:CGRect!
        let halfSize:CGFloat = self.view.frame.width * 0.5
        let thickness:CGFloat = self.view.frame.width * 0.1
        let thickness_half:CGFloat = self.view.frame.width * 0.05
        switch direction{
        case .Up:
            frame = CGRect(x: halfSize - thickness_half, y: 0, width: thickness, height: halfSize)
        case .Down:
            frame = CGRect(x: halfSize - thickness_half, y: halfSize, width: thickness, height: halfSize)
        case .Left:
            frame = CGRect(x: 0, y: halfSize - thickness_half, width: halfSize, height: thickness)
        case .Right:
            frame = CGRect(x: halfSize, y: halfSize - thickness_half, width: halfSize, height: thickness)
        }
        
        let connection = UIView(frame: frame)
        connection.backgroundColor = UIColor.blackColor()
        self.connectionView.addSubview(connection)
    }
    
    func turnOnAvailability(onOff: Bool) {
        self.onOff.hidden = !onOff
    }
    
}

