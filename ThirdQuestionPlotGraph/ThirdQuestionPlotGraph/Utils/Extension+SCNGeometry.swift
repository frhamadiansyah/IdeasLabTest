//
//  Extension+SCNGeometry.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 15/08/24.
//

import Foundation
import SceneKit

extension SCNGeometry {
    // this function to make a line with adjustable line radius
    class func cylinderLine(from: SCNVector3, to: SCNVector3,
                            segments: Int = 5, color: UIColor = UIColor.magenta, radius: CGFloat = 0.01) -> SCNNode {
        // breakdown the coordinate
        let x1 = from.x; let x2 = to.x
        let y1 = from.y; let y2 = to.y
        let z1 = from.z; let z2 = to.z
        
        let subExpr01 = Float((x2-x1) * (x2-x1))
        let subExpr02 = Float((y2-y1) * (y2-y1))
        let subExpr03 = Float((z2-z1) * (z2-z1))
        
        // get the distance between two point with pythagoras theorem
        let distance = Float(sqrtf(subExpr01 + subExpr02 + subExpr03))
        
        // create cylinder with the distance as height
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(distance))
        cylinder.radialSegmentCount = segments
        cylinder.firstMaterial?.diffuse.contents = color
        
        let lineNode = SCNNode(geometry: cylinder)
        
        // get the center of coordinate for the cylinder position
        lineNode.position = SCNVector3((x1+x2)/2, (y1+y2)/2, (z1+z2)/2)
        
        lineNode.eulerAngles = SCNVector3(x: Float.pi / 2,
                                      y: acos((to.z-from.z)/distance),
                                      z: atan2((to.y-from.y), (to.x-from.x)))
        return lineNode
    }
}

