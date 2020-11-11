//
//  Menu.swift
//  app2
//
//  Created by david robertson on 11/8/20.
//  Copyright © 2020 david robertson. All rights reserved.
//


import SpriteKit
import GameplayKit

class Menu: SKScene {
     let gameStart = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
         
        gameStart.text = "Play now"
        gameStart.fontSize = 40
        gameStart.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gameStart.position = CGPoint(x: 0, y: -250)
        gameStart.fontName = "Verdana Bold"
        gameStart.name = "button"
        self.addChild(gameStart)
        
        let logo = SKSpriteNode(imageNamed: "eastwood-hunter-in-the-forest")
        logo.size = CGSize(width: 500, height: 500)
        logo.position = CGPoint(x: 0, y: 200)
        self.addChild(logo)

        let gameName = SKLabelNode()
        gameName.text = "BirdHunter"
        gameName.fontSize = 40
        gameName.fontName = "Verdana Bold"
        gameName.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gameName.position = CGPoint(x: 0, y: -150)
        gameName.name = "button2"
        self.addChild(gameName)
       
        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let pointOfTouch = touch.location(in: self)
        
            if gameStart.contains(pointOfTouch) {
               if let nextScene = GameScene(fileNamed: "GameScene") {
                    nextScene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 0.5)
                    self.view?.presentScene(nextScene, transition: transition)
                
                }
            }
        }
          
       
    }

 
}
