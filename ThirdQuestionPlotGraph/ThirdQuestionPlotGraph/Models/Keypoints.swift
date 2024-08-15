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
    func get2DCoordinate(_ bounds: CGRect) -> CGPoint {
        let centerX = bounds.width / 2
        let centerY = bounds.height / 2
        
        let min = min(bounds.height, bounds.width)
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
