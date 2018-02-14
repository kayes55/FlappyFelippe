//  Created by Imrul Kayes on 2/12/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit

// MARK: - "randomNumber" Added by Imrul Kayes at 12:32 AM 13th February, 2018
func randomNumber(_ range:Range<Int>) -> Int
{
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
}

public extension SKAction {
  /**
   * Creates a screen shake animation.
   *
   * @param node The node to shake. You cannot apply this effect to an SKScene.
   * @param amount The vector by which the node is displaced.
   * @param oscillations The number of oscillations; 10 is a good value.
   * @param duration How long the effect lasts. Shorter is better.
   */
    public class func screenShakeWithNode(node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldPosition = node.position
    let newPosition = oldPosition + amount
    
    let effect = SKTMoveEffect(node: node, duration: duration, startPosition: newPosition, endPosition: oldPosition)
    
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)

        return SKAction.actionWithEffect(effect: effect)
  }

  /**
   * Creates a screen rotation animation.
   *
   * @param node You usually want to apply this effect to a pivot node that is
   *        centered in the scene. You cannot apply the effect to an SKScene.
   * @param angle The angle in radians.
   * @param oscillations The number of oscillations; 10 is a good value.
   * @param duration How long the effect lasts. Shorter is better.
   */
    public class func screenRotateWithNode(node: SKNode, angle: CGFloat, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldAngle = node.zRotation
    let newAngle = oldAngle + angle
    
    let effect = SKTRotateEffect(node: node, duration: duration, startAngle: newAngle, endAngle: oldAngle)
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)

        return SKAction.actionWithEffect(effect: effect)
  }

  /**
   * Creates a screen zoom animation.
   *
   * @param node You usually want to apply this effect to a pivot node that is
   *        centered in the scene. You cannot apply the effect to an SKScene.
   * @param amount How much to scale the node in the X and Y directions.
   * @param oscillations The number of oscillations; 10 is a good value.
   * @param duration How long the effect lasts. Shorter is better.
   */
    public class func screenZoomWithNode(node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldScale = CGPoint(x: node.xScale, y: node.yScale)
    let newScale = oldScale * amount
    
    let effect = SKTScaleEffect(node: node, duration: duration, startScale: newScale, endScale: oldScale)
        effect.timingFunction = SKTCreateShakeFunction(oscillations: oscillations)

        return SKAction.actionWithEffect(effect: effect)
  }

  /**
   * Causes the scene background to flash for duration seconds.
   */
    public class func colorGlitchWithScene(scene: SKScene, originalColor: SKColor, duration: TimeInterval) -> SKAction {
        return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
      if elapsedTime < CGFloat(duration) {
//        scene.backgroundColor = SKColorWithRGB(r: Int.random(0...255), g: Int.random(0...255), b: Int.random(0...255))
        scene.backgroundColor = SKColorWithRGB(r: randomNumber(0..<255) , g: randomNumber(0..<255), b: randomNumber(0..<255))
      } else {
        scene.backgroundColor = originalColor
      }
    }
  }
    
    
}
