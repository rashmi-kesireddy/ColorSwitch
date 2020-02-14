//
//  MenuScene.swift
//  ColorSwitchFun
//
//  Created by VamshiKrishna Giri on 2/13/20.
//  Copyright © 2020 Rashmi Kesireddy. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    override func didMove(to view: SKView) {
         backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/2, height: frame.size.width/2)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap To Play")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 50
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(for: playLabel)
        
        let highScoreLabel = SKLabelNode(text: "High Score" + " \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = "AvenirNext-Bold"
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = .white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*2)
        addChild(highScoreLabel)
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score" + " \(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLabel.fontName = "AvenirNext-Bold"
        recentScoreLabel.fontSize = 30
        recentScoreLabel.fontColor = .white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y -  recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    func animate(for label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene)
    }
}
