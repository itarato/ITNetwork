//
//  TileViewController.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import UIKit

class TileViewController : UIViewController {

    @IBOutlet weak var connectionUp: UILabel!
    @IBOutlet weak var connectionRight: UILabel!
    @IBOutlet weak var connectionDown: UILabel!
    @IBOutlet weak var connectionLeft: UILabel!
    @IBOutlet weak var server: UILabel!
    @IBOutlet weak var computer: UILabel!
    @IBOutlet weak var connectionView: UIView!
    
    init() {
        super.init(nibName: "TileView", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.connectionDown.hidden = true
        self.connectionUp.hidden = true
        self.connectionLeft.hidden = true
        self.connectionRight.hidden = true
        self.computer.hidden = true
        self.server.hidden = true
    }
    
    @IBAction func onTap(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.connectionView.transform = CGAffineTransformRotate(self.connectionView.transform, CGFloat(M_PI / 2))
        }
    }
    
}

