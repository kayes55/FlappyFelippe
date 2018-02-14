//  Created by Imrul Kayes on 2/12/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import SpriteKit

public func SKColorWithRGB(r: Int, g: Int, b: Int) -> SKColor {
  return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

public func SKColorWithRGBA(r: Int, g: Int, b: Int, a: Int) -> SKColor {
  return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
}
