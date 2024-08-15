//
//  JSONUtils.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 14/08/24.
//

import Foundation
import SceneKit

struct JSONUtils {
    static func readLocalFile(forName name: String) -> [Keypoints] {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let result = try JSONDecoder().decode([Keypoints].self, from: jsonData)
                let sorted = result.sorted { $0.id > $1.id }
                return sorted
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func getMinMaxFloatValue(_ data : [Keypoints]) -> (minX: Float, maxX: Float, minY: Float, maxY: Float, minZ: Float, maxZ: Float) {
        let coordinates = data.map {$0.get3DCoordinate()}
        
        let xPoints =  coordinates.compactMap {$0.x}
        let minX = xPoints.min()
        let maxX = xPoints.max()
        
        let yPoints =  coordinates.compactMap {$0.y}
        let minY = yPoints.min()
        let maxY = yPoints.max()
        
        let zPoints =  coordinates.compactMap {$0.z}
        let minZ = zPoints.min()
        let maxZ = zPoints.max()
        
        return (minX: minX ?? 0,
                maxX: maxX ?? 0,
                minY: minY ?? 0,
                maxY: maxY ?? 0,
                minZ: minZ ?? 0,
                maxZ: maxZ ?? 0)
    }
}
