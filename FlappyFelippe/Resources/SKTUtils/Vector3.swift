//  Created by Imrul Kayes on 2/12/18.
//  Copyright © 2018 Imrul Kayes. All rights reserved.
//

import CoreGraphics

public struct Vector3: Equatable {
  var x: CGFloat
  var y: CGFloat
  var z: CGFloat
    
  public init(x: CGFloat, y: CGFloat, z: CGFloat) {
    self.x = x
    self.y = y
    self.z = z
  }
}

public func == (lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

extension Vector3 {
  /**
   * Returns true if all the vector elements are equal to the provided value.
   */
  public func equalToScalar(value: CGFloat) -> Bool {
    return x == value && y == value && z == value
  }
  
  /**
   * Returns the magnitude of the vector.
   **/
  public func length() -> CGFloat {
    return sqrt(x*x + y*y + z*z)
  }
  
  /**
   * Normalizes the vector and returns the result as a new vector.
   */
  public func normalized() -> Vector3 {
    let scale = 1.0/length()
    return Vector3(x: x * scale, y: y * scale, z: z * scale)
  }
  
  /**
   * Normalizes the vector described by this Vector3 object.
   */
  public mutating func normalize() {
    let scale = 1.0/length()
    x *= scale
    y *= scale
    z *= scale
  }
  
  /**
   * Calculates the dot product of two vectors.
   */
  public static func dotProduct(left: Vector3, right: Vector3) -> CGFloat {
    return left.x * right.x + left.y * right.y + left.z * right.z
  }
  
  /**
   * Calculates the cross product of two vectors.
   */
  public static func crossProduct(left: Vector3, right: Vector3) -> Vector3 {
    let crossProduct = Vector3(x: left.y * right.z - left.z * right.y,
                               y: left.z * right.x - left.x * right.z,
                               z: left.x * right.y - left.y * right.x)
    return crossProduct
  }
}
