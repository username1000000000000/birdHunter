//
//  GameOver.swift
//  app2
//
//  Created by david robertson on 11/10/20.
//  Copyright © 2020 david robertson. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameOver: SKScene {
    
    let gameOverLabel = SKLabelNode()
    
    let homeLabel = SKLabelNode()
    let gameScoreLabel = SKLabelNode()
    override func didMove(to view: SKView) {
        
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gameOverLabel.fontSize = 50
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        gameOverLabel.zPosition = 2
        self.addChild(gameOverLabel)
        
        
 
        
        
        homeLabel.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        homeLabel.text = "Home"
        homeLabel.fontSize = 50
        homeLabel.position = CGPoint(x: 0, y: -200)
        homeLabel.zPosition = 2
        self.addChild(homeLabel)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
              let pointOfTouch = touch.location(in: self)
          
              if homeLabel.contains(pointOfTouch) {
                 if let nextScene = Menu(fileNamed: "Menu") {
                      nextScene.scaleMode = .aspectFill
                  let transition = SKTransition.crossFade(withDuration: 0.5)
                      self.view?.presentScene(nextScene, transition: transition)
                  
                  }
             
                }
              
                
              }
          }
          
       
    }

