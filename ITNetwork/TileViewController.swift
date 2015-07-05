//
//  TileViewController.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import UIKit

class TileViewController : UIViewController, ITNetworkNode {
    
    @IBOutlet weak var server: UIView!
    @IBOutlet weak var serverLight: UIView!
    @IBOutlet weak var computer: UIView!
    @IBOutlet weak var onOff: UIView!
    @IBOutlet weak var connectionView: UIView!
    
    weak var vertex: Vertex?
    
    deinit {
        self.server = nil
        self.serverLight = nil
        self.computer = nil
        self.onOff = nil
        self.vertex = nil
        for subview in self.connectionView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        self.vertex?.rotateRight()
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rotate()
        }) { (Bool) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(ITNETWORK_EVENT_DID_TAP, object: nil)
        }
    }
    
    func rotate() {
        self.connectionView.transform = CGAffineTransformRotate(self.connectionView.transform, CGFloat(M_PI / 2))
    }
    
    func setComputer() {
        self.computer.hidden = false
        self.onOff.hidden = false
    }
    
    func setServer() {
        self.server.hidden = false
        self.serverLight.hidden = false
    }
    
    func setConnection(direction: VertexConnectionDirecion) {
        let frame:CGRect!
        let thickness:CGFloat = self.view.frame.width * 0.1
        let thickness_half:CGFloat = self.view.frame.width * 0.05
        let halfSize:CGFloat = self.view.frame.width * 0.5 + thickness_half
        switch direction{
        case .Up:
            frame = CGRect(x: halfSize - thickness, y: 0, width: thickness, height: halfSize)
        case .Down:
            frame = CGRect(x: halfSize - thickness, y: halfSize - thickness_half, width: thickness, height: halfSize)
        case .Left:
            frame = CGRect(x: 0, y: halfSize - thickness, width: halfSize, height: thickness)
        case .Right:
            frame = CGRect(x: halfSize - thickness, y: halfSize - thickness, width: halfSize, height: thickness)
        }
        
        let connection = UIView(frame: frame)
        connection.backgroundColor = UIColor.blackColor()
        self.connectionView.addSubview(connection)
    }
    
    func setAvailability(onOff: Bool) {
        self.onOff.backgroundColor = onOff ? UIColor.greenColor() : UIColor.darkGrayColor()
    }
    
}

