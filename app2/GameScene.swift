//
//  GameScene.swift
//  app2
//
//  Created by david robertson on 11/4/20.
//  Copyright © 2020 david robertson. All rights reserved.
//

import SpriteKit
import GameplayKit


struct Category
{
    static let bullet: UInt32 = 0b1
    static let seagull: UInt32 = 0b10
    static let bluejay: UInt32 = 0b100
    static let hummingbird: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ground = SKSpriteNode()
    var hunter = SKSpriteNode()
    var tree = SKSpriteNode()
    var sun = SKSpriteNode()
    var bullet = SKSpriteNode()
    var wrongKills = 0
    var kills = 0
   var scoreLabel = SKLabelNode()
   var wrongKillsLabel = SKLabelNode()
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
  
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        ground = SKSpriteNode(imageNamed: "Ground")
        ground.setScale(0.5)
        ground.position = CGPoint(x: 0, y: -640)
        ground.xScale = 2
        ground.yScale = 1
        ground.zPosition = 2
        self.addChild(ground)
        
        hunter = SKSpriteNode(imageNamed: "hunter-2")
        hunter.position = CGPoint(x: 0, y: -520)
        hunter.size = CGSize(width: 100, height: 100)
        hunter.zPosition = 3
        self.addChild(hunter)
        
        tree = SKSpriteNode(imageNamed: "tree")
        tree.size = CGSize(width: 500, height: 500)
        tree.position = CGPoint(x: 0, y: -400)
        self.addChild(tree)
        
        sun = SKSpriteNode(imageNamed: "sun")
        sun.size = CGSize(width: 100, height: 100)
        sun.position = CGPoint(x: 0, y: 500)
        sun.zPosition = 1
        self.addChild(sun)
        
      
        
        
        wrongKillsLabel.text = "WrongKills: \(String(wrongKills))"
        
        
        scoreLabel.fontSize = 25
        scoreLabel.position = CGPoint(x: -200, y: 500)
        scoreLabel.text = "Kills: 0"
        scoreLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scoreLabel.fontName = "Trebuchet MS Bold"
        self.addChild(scoreLabel)
        
        wrongKillsLabel.fontSize = 25
        wrongKillsLabel.fontName = "Trebuchet MS Bold"
        wrongKillsLabel.position = CGPoint(x: 200, y: 500)
        wrongKillsLabel.fontColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        wrongKillsLabel.text = "Wrong Kills: 0"
        self.addChild(wrongKillsLabel)
       
        startGame()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        fireGun()
       
        
    }
    func addScore() {
        kills += 1
        scoreLabel.text = "Kills: \(String(kills))"
      
    }
    func addWrongScore() {
            wrongKills += 1
            wrongKillsLabel.text = "Wrong Kills: \(String(wrongKills))"
        if wrongKills == 10 {
           print("Game over!")
         
                 if let nextScene = GameOver(fileNamed: "GameOver") {
                               nextScene.scaleMode = .aspectFill
                           let transition = SKTransition.crossFade(withDuration: 0.5)
                               self.view?.presentScene(nextScene, transition: transition)
                            
                           }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            hunter.position.x += amountDragged
        }
    }
    func startGame() {
        let spawn = SKAction.run(spawnBirds)
        let spawn2 = SKAction.run(spawnBlueJay)
        let spawn3 = SKAction.run(spawnHummingbird)
        let waitToSpawn = SKAction.wait(forDuration: 2)
        let spawnSequence = SKAction.sequence([spawn, spawn2, spawn3, waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    func fireGun() {
        bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.size = CGSize(width: 20, height: 20)
        bullet.position = hunter.position
        bullet.zPosition = 2
        bullet.physicsBody?.isDynamic = false
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.categoryBitMask = Category.bullet
        bullet.physicsBody?.collisionBitMask = Category.seagull | Category.bluejay | Category.hummingbird
        bullet.physicsBody?.contactTestBitMask = Category.seagull | Category.bluejay | Category.hummingbird
        self.addChild(bullet)
        let moveBullet = SKAction.moveTo(y: 700, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    func spawnBirds() {
     let randomStart = random(min: CGFloat(500), max: CGFloat(300))
        let randomEnd = random(min: CGFloat(-500), max: CGFloat(-500))
        
        let start = CGPoint(x: 500, y: randomStart)
        let end = CGPoint(x: -500, y: randomEnd)
        
        var bird = SKSpriteNode(imageNamed: "seagull")
        bird.position = start
        bird.zPosition = 3
        bird.size = CGSize(width: 80, height: 80)
        bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.allowsRotation = true
        bird.physicsBody?.categoryBitMask = Category.seagull
        bird.physicsBody?.collisionBitMask = Category.bullet
        bird.physicsBody?.contactTestBitMask = Category.bullet
        bird.physicsBody?.isDynamic = false
        bird.physicsBody?.restitution = 1
        self.addChild(bird)
        
        let moveBird = SKAction.move(to: CGPoint(x: -500, y: Int.random(in: 400...600)), duration: 2)
        let deleteBird = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveBird, deleteBird])
        bird.run(sequence)
        
    }
    func spawnBlueJay() {
        let randomStart = random(min: CGFloat(600), max: CGFloat(300))
        let randomEnd = random(min: CGFloat(-600), max: CGFloat(-300))
        let start = CGPoint(x: 500, y: randomStart)
        let end = CGPoint(x: -500, y: randomEnd)
        let bird = SKSpriteNode(imageNamed: "bird")
        bird.zPosition = 3
        bird.position = start
        bird.size = CGSize(width: 80, height: 80)
        bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.categoryBitMask = Category.bluejay
        bird.physicsBody?.collisionBitMask = Category.bullet
        bird.physicsBody?.contactTestBitMask = Category.bullet
        bird.physicsBody?.isDynamic = false
        bird.physicsBody?.restitution = 1
        self.addChild(bird)
         
        let moveBird = SKAction.move(to: CGPoint(x: -500, y: Int.random(in: 300...600)), duration: TimeInterval(Int.random(in: 2...8)))
        let deleteBird = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveBird, deleteBird])
        bird.run(sequence)
         
     }
    func spawnHummingbird() {
        let randomStart = random(min: CGFloat(600), max: CGFloat(300))
        let randomEnd = random(min: CGFloat(-600), max: CGFloat(-300))
        let start = CGPoint(x: -500, y: randomStart)
        let end = CGPoint(x: 500, y: randomEnd)
        let bird = SKSpriteNode(imageNamed: "hummingbird")
            bird.zPosition = 3
            bird.position = start
            bird.size = CGSize(width: 80, height: 80)
            bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
            bird.physicsBody?.isDynamic = true
            bird.physicsBody?.affectedByGravity = false
            bird.physicsBody?.categoryBitMask = Category.hummingbird
            bird.physicsBody?.collisionBitMask = Category.bullet
            bird.physicsBody?.contactTestBitMask = Category.bullet
            bird.physicsBody?.isDynamic = false
            bird.physicsBody?.restitution = 1
        
        self.addChild(bird)
    
        let moveBird = SKAction.moveTo(x: 500, duration: TimeInterval(Int.random(in: 2...8)))
        let deleteBird = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveBird, deleteBird])
        bird.run(sequence)
       }
    func didBegin(_ contact: SKPhysicsContact) {
        
            var body1 = SKPhysicsBody()
            var body2 = SKPhysicsBody()
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                body1 = contact.bodyA
                body2 = contact.bodyB
            } else {
                body1 = contact.bodyB
                body2 = contact.bodyA
            }
            if body1.categoryBitMask == Category.bullet && body2.categoryBitMask == Category.seagull {
                    addScore()
                     bulletContact(spawnPosition: body2.node!.position)
               body1.node?.removeFromParent()
                body2.node?.removeFromParent()
         
            }
        if body1.categoryBitMask == Category.bullet && body2.categoryBitMask == Category.bluejay {
            bulletContact(spawnPosition: body2.node!.position)
            addWrongScore()
             body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        if body1.categoryBitMask == Category.bullet && body2.categoryBitMask == Category.hummingbird {
                   bulletContact(spawnPosition: body2.node!.position)
                   addWrongScore()
                    body1.node?.removeFromParent()
                   body2.node?.removeFromParent()
               }
         
        }
    func bulletContact(spawnPosition: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 4
        explosion.size = CGSize(width: 60, height: 60)
        self.addChild(explosion)
        
        let scale = SKAction.scale(by: 1, duration: 0.1)
        let fade = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([scale, fade, delete])
        explosion.run(sequence)
    }
    
    func nextView() {
        let action = SKAction.run(transition)
        let change = SKAction.wait(forDuration: 1)
        let sequence = SKAction.sequence([change, action])
        self.run(sequence)
    }
    func transition() {
        let scene = GameOver(size: self.size)
        scene.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
}
    
    

