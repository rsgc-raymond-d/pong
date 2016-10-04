//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Declare any properties you need for your sketch below this comment, but before init()
    var h = -5
    var x = 400
    var y = 250
    var v = 5
    var counter1 = 0
    var counter2 = 0
    var Diablo : Bool = false // Boolean to toggle whether background is red
    var lastMouseY : Float = 0
    var gameOver : Bool = false
    var gameSuccess : Bool = false
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 800, height: 500)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
        // Vertical position of circle
        y = y + v
        
        // Horizontal position
        x = x + h
        
        // Top & Bottom Borders
        if (y > canvas.height - 20 || y < 15) {
            v *= -1
        }
        
        // reset of circle when it goes off the canvas
        if (x < -5 || x > 800) {
            x = canvas.width / 2
            y = canvas.height / 2
        }
        
        // Hitbox detection for the paddle
        if (x == 720) {
            if (y < Int(canvas.mouseY) + 25 && Int(canvas.mouseY) - 25 < y) {
                h *= -1
                counter2 = counter2 + 1
            }
        }
        
        // Left Wall
        if (x < 0) {
            h *= -1
        }
        
        // Display score
        canvas.textColor = Color (hue: 60, saturation: 80, brightness: 90, alpha: 100)
        canvas.drawText(message: "Misses", size: 20, x: 48, y: 480)
        canvas.drawText(message: "Hits", size: 20, x: 726, y: 480)
        canvas.drawText(message: String(counter1), size: 50, x: 60, y: 430)
        canvas.drawText(message: String(counter2), size: 50, x: 730, y: 430)
        if (x > 795) {
            counter1 = counter1 + 1
        }
        
        // Timer
        if gameOver == false {
            canvas.drawText(message: "Timer: \(60 - canvas.frameCount / 60 + (counter2 * 3))", size: 40, x: 330, y: 20)
        }
        
        // End of Timer Ball reset
        if gameSuccess == false {
            if (canvas.frameCount - (counter2 * 3) == 3600) {
                gameOver = true
                x = canvas.width / 2
                y = canvas.height / 2
                v = 0
                h = 0
            }
        }
        // Misses reaches 10
        if gameSuccess == false {
            if counter1 == 20 {
                gameOver = true
            }
        }
        
        // show the game over message
        if gameOver == true {
            canvas.textColor = Color (hue: 0, saturation: 0, brightness: 100, alpha: 100)
            canvas.drawText(message: "Game Over", size: 100, x: 150, y: 225)
        }
        
        // Game Win
        if counter2 == 10 {
            gameSuccess = true
            x = canvas.width / 2
            y = canvas.height / 2
            v = 0
            h = 0
        }
        if gameSuccess == true {
            canvas.drawText(message: "You Win", size: 100, x: 150, y: 225)
        }
        
        canvas.textColor = Color (hue: 60, saturation: 80, brightness: 0, alpha: 100)
        
        // Decide what color to make the background
        if (Diablo == true) {
            canvas.fillColor = Color(hue: 0, saturation: 80, brightness: 0, alpha: 100)
        } else {
            canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 10)
        }
        canvas.drawRectangle(bottomRightX: 0, bottomRightY: 0, width: canvas.width, height: canvas.height)
        
        // Hey where did the person click?
        canvas.drawText(message: String(lastMouseY))
        
        canvas.drawShapesWithBorders = false
        canvas.fillColor = Color(hue: Float(canvas.frameCount), saturation: 80, brightness: 90, alpha: 100)
        canvas.drawEllipse(centreX: x, centreY: y, width: 20, height: 20)
        
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        // Save the location of the last mouse click
        lastMouseY = canvas.mouseY
        
        if lastMouseY != 0 {
            canvas.fillColor = Color(hue: 50, saturation: 0, brightness: 100, alpha: 100)
            canvas.drawRectangle(bottomRightX: 730, bottomRightY: Int(canvas.mouseY) - 25, width: 15, height: 50)
        }
    }
    
}