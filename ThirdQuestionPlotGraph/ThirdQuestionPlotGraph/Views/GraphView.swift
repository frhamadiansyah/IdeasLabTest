//
//  GraphView.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 14/08/24.
//

import UIKit

class GraphView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .white
        
        let data = JSONUtils.readLocalFile(forName: "TW_Keypoints")
        
        plot2DGraph(datapoint: data, to: layer)
        
    }
    
    func plot2DGraph(datapoint: [Keypoints], to layer: CALayer) {
        
        let data = datapoint.map({$0.get2DCoordinate(bounds)})
        
        for i in 1..<data.count {
            let point = data[i]
            // we use multiple UIBezierPath instead of one path because we want to do color gradient along the lines. In order to do that we use multiple UIBezierPath
            let path = UIBezierPath()
            
            // add line on path
            path.move(to: data[i-1])
            path.addLine(to: point)
            
            // add color on that segment of line
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.lineWidth = 2
            
            
            // To get the proper color gradient, we plot the color hue in arctan graph, because there less color changes on the beginning and end of graph, and arctan graph can capture that
            
            // squeezeXCoefficient is the coefficient to squeze the x axis, we squeze the x axis because we don't want to get the whole graph, and we want to zoom in on the transition period near the X = 0 point, to get a smoother transition between red and green.
            let squeezeXCoefficient: CGFloat = 0.03
            
            // hueRangeCoefficient is the coefficient to set hue range so the transition only happen between red and green color
            let hueRangeCoefficient: CGFloat = 0.12
            
            // shiftXValue is the value to shift the arctan graph along x axis, so we can adjust where the hue transition should take place
            let shiftXValue: CGFloat = CGFloat(data.count) / CGFloat(2.4)
            
            // const is the shifting value so the range graph is start from 0, instead of negative value
            let const: CGFloat = atan(shiftXValue * squeezeXCoefficient)
            let adjustedX = (CGFloat(i) - shiftXValue) * squeezeXCoefficient
            let atanValue = atan(adjustedX)
            let hue = (atanValue + const) * hueRangeCoefficient
            
            if i == 1 || i == data.count - 1 {
                print("atan = \(atanValue) hue = \(hue), i = \(i), const = \(const)")
            }
            
            // use the hue value to generate color
            shapeLayer.strokeColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1).cgColor
            shapeLayer.fillColor = .none
            shapeLayer.lineCap = .round
            layer.addSublayer(shapeLayer)
            
                                let hueColor = UIBezierPath()
            
                                hueColor.addArc(withCenter: CGPoint(x: (CGFloat(i) / CGFloat(5)) + 10, y: (hue * 10) + 50), radius: 1, startAngle: 0, endAngle: 1, clockwise: true)
                                let newshapeLayer = CAShapeLayer()
                                newshapeLayer.path = hueColor.cgPath
                                newshapeLayer.lineWidth = 3
                                newshapeLayer.strokeColor = UIColor.black.cgColor
                                layer.addSublayer(newshapeLayer)
        }
    }
}


