//
//  KeyPoints.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 14/08/24.
//

import Foundation
import SceneKit

struct Keypoints: Decodable {
    var id: Int
    var keypoints: [Float]
    func get2DCoordinate(center: CGPoint, scale: CGFloat) -> CGPoint {
        let x = (CGFloat(keypoints[0]) * scale) + center.x
        let y = (CGFloat(keypoints[1]) * scale) + center.y
        return CGPoint(x: x, y: y)
    }
    
    func get2DCoordinate(midX: CGFloat, midY: CGFloat, canvasWidth: CGFloat, canvasHeight: CGFloat, graphWidth: CGFloat, graphHeight: CGFloat) -> CGPoint {
        let centerX = midX
        let centerY = midY
        
        let widthScale = canvasWidth / graphWidth
        let heightScale = canvasHeight / graphHeight
        let min = min(widthScale, heightScale)
        let scale = min
        
        let x = (CGFloat(keypoints[0]) * scale) + centerX
        let y = (CGFloat(keypoints[1]) * scale) + centerY
        return CGPoint(x: x, y: y)
        
    }
    
    func get3DCoordinate(_ scale: Float = 1) -> SCNVector3 {

        let x = keypoints[0] * scale
        let y = keypoints[1] * scale
        let z = keypoints[2] * scale
        
        return SCNVector3(Float(x), Float(y), Float(z))
    }
}
