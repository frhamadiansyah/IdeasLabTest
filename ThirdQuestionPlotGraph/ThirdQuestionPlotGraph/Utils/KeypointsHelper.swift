//
//  KeypointsHelper.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 15/08/24.
//

import Foundation
import SceneKit

struct KeypointsHelper {
    func readLocalFile(forName name: String) -> [Keypoints] {
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
    
    func getMinMaxFloatValue(_ data : [Keypoints]) -> (minX: Float, midX: Float, maxX: Float, minY: Float, midY: Float, maxY: Float, minZ: Float, midZ: Float, maxZ: Float) {
        let coordinates = data.map {$0.get3DCoordinate()}
        
        let xPoints =  coordinates.compactMap {$0.x}
        let minX = xPoints.min()
        let maxX = xPoints.max()
        let midX = ((abs(minX ?? 0) + abs(maxX ?? 0)) / 2) + (minX ?? 0)
        
        let yPoints =  coordinates.compactMap {$0.y}
        let minY = yPoints.min()
        let maxY = yPoints.max()
        let midY = ((abs(minY ?? 0) + abs(maxY ?? 0)) / 2) + (minY ?? 0)
        
        let zPoints =  coordinates.compactMap {$0.z}
        let minZ = zPoints.min()
        let maxZ = zPoints.max()
        let midZ = ((abs(minZ ?? 0) + abs(maxZ ?? 0)) / 2) + (minZ ?? 0)
        
        return (minX: minX ?? 0,
                midX: midX,
                maxX: maxX ?? 0,
                minY: minY ?? 0,
                midY: midY,
                maxY: maxY ?? 0,
                minZ: minZ ?? 0,
                midZ: midZ,
                maxZ: maxZ ?? 0)
    }
    
    func calculateCenterAndScale(datapoint: [Keypoints], inset: CGFloat, bounds: CGRect) -> (center: CGPoint, scale: CGFloat) {
        // add padding to make bounds smaller
        let smaller = bounds.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right:inset))
        
        let minMax = getMinMaxFloatValue(datapoint)
        
        // get total graph width and height
        let graphWidth = CGFloat(minMax.maxX - minMax.minX)
        let graphHeight = CGFloat(minMax.maxY - minMax.minY)
        
        var scale: CGFloat = 1
        // adjust scale with device orientation
        if smaller.width < smaller.height {
            scale = smaller.width / graphWidth
        } else {
            scale = smaller.height / graphHeight
        }
        
        // since point zero is in top leading, adjust graph to center of screen
        let midX = (bounds.width / 2) - (CGFloat(minMax.midX) * scale)
        let midY = (bounds.height / 2) - (CGFloat(minMax.midY) * scale)
        let center = CGPoint(x: Double(midX), y: Double(midY))
        
        return (center: center, scale: scale)
    }
}
