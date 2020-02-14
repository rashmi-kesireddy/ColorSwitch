//
//  GameScene.swift
//  ColorSwitchFun
//
//  Created by Rashmi Kesireddy on 2/12/20.
//  Copyright © 2020 Rashmi Kesireddy. All rights reserved.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState: Int {
    case red, yellow, green, blue
}

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    
    let scorLabel = SKLabelNode(text: "0")
    var scoreCt = 0
    
    override func didMove(to view: SKView) {
        setUpPhysics()
        layoutScene()
    }
    
    func setUpPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        // setup the colorswitch image, size and position
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        // add simulations
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
        scorLabel.fontName = "AvenirNext-Bold"
        scorLabel.fontSize = 60
        scorLabel.fontColor = .white
        scorLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scorLabel.zPosition = ZPositions.label
        addChild(scorLabel)
        
        layoutBall()
    }
    
    func updateScoreLabel() {
        scorLabel.text = "\(scoreCt)"
    }
    
    func layoutBall() {
        let randomColor = PlayColors.colors.randomElement()
        currentColorIndex = PlayColors.colors.firstIndex(of: randomColor!)
        
        // setup the ball image, size and position
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "whiteBall"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30, height: 30))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.zPosition = ZPositions.ball
        // add simulations to it
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver() {
        UserDefaults.standard.set(scoreCt, forKey: "RecentScore")
        if scoreCt > UserDefaults.standard.integer(forKey: "HighScore") {
            UserDefaults.standard.set(scoreCt, forKey: "HighScore")
        }
        
        let menuScene = MenuScene(size: view!.bounds.size)
        view?.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue {
                    run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    scoreCt += 1
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.25)) {
                        ball.removeFromParent()
                        self.layoutBall()
                    }
                } else {
                    gameOver()
                }
            }
        }
    }
    
}
