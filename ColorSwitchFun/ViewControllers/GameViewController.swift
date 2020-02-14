//
//  GameViewController.swift
//  ColorSwitchFun
//
//  Created by Rashmi Kesireddy on 2/12/20.
//  Copyright © 2020 Rashmi Kesireddy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
//            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
