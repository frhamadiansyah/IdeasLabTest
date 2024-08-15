//
//  ThreeDViewController.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 14/08/24.
//

import UIKit
import SceneKit

class ThreeDViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sceneView = SCNView(frame: view.frame)
        self.view.addSubview(sceneView)
        let scene = SCNScene()
        sceneView.scene = scene
        
        // Setup the camera
        let cameraDistance: Float = 5

        setupSceneEnvironment(cameraDistance: cameraDistance, to: scene)
        
        // Allow user to manipulate the camera
        sceneView.allowsCameraControl = true
        
        // Add data points
        let data = JSONUtils.readLocalFile(forName: "CA_Keypoints")
        let dataPoints = data.map {$0.get3DCoordinate()}

        addCylinderThroughDataPoints(dataPoints, to: scene)
        
        // Do any additional setup after loading the view.
    }
    
    func setupSceneEnvironment(cameraDistance: Float = 3, to scene: SCNScene) {
        
        // Setup the camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: cameraDistance)
        scene.rootNode.addChildNode(cameraNode)
        
        let floor = SCNFloor()
        floor.reflectivity = 0.5   // Set reflectivity (0.0 to 1.0)
        floor.reflectionFalloffEnd = 10.0
        
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(0, -5, 0)
        floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        scene.rootNode.addChildNode(floorNode)
        
        // Add light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // Add ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
    }

    
    func addLineThroughDataPoints(_ vertices: [SCNVector3], to scene: SCNScene) {
        
        // Create the vertex source
        let vertexSource = SCNGeometrySource(vertices: vertices)
        
        // Create the indices for the lines
        var indices: [UInt32] = []
        for i in 0..<vertices.count - 1 {
            indices.append(UInt32(i))
            indices.append(UInt32(i + 1))
        }
        
        // Create the geometry element
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        // Create the geometry
        let lineGeometry = SCNGeometry(sources: [vertexSource], elements: [element])
        lineGeometry.firstMaterial?.diffuse.contents = UIColor.orange
        
        
        // Create a node with the line geometry
        let lineNode = SCNNode(geometry: lineGeometry)
        
        // Add the line node to the scene
        scene.rootNode.addChildNode(lineNode)
    }
    
    func addCylinderThroughDataPoints(_ vertices: [SCNVector3], to scene: SCNScene) {
        for i in 0..<vertices.count - 1 {
            scene.rootNode.addChildNode(SCNGeometry.cylinderLine(from: vertices[i], to: vertices[i + 1]))
        }
    }
    
    
    func addAxes(to scene: SCNScene) {
        let axisLength: CGFloat = 5.0
        
        let xAxis = SCNCylinder(radius: 0.02, height: axisLength)
        xAxis.firstMaterial?.diffuse.contents = UIColor.red
        let xAxisNode = SCNNode(geometry: xAxis)
        xAxisNode.position = SCNVector3(0, 0, 0)
        xAxisNode.eulerAngles = SCNVector3(0, 0, Float.pi / 2)
        scene.rootNode.addChildNode(xAxisNode)
        
        let yAxis = SCNCylinder(radius: 0.02, height: axisLength)
        yAxis.firstMaterial?.diffuse.contents = UIColor.green
        let yAxisNode = SCNNode(geometry: yAxis)
        yAxisNode.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(yAxisNode)
        
        let zAxis = SCNCylinder(radius: 0.02, height: axisLength)
        zAxis.firstMaterial?.diffuse.contents = UIColor.blue
        let zAxisNode = SCNNode(geometry: zAxis)
        zAxisNode.position = SCNVector3(0, 0, 0)
        zAxisNode.eulerAngles = SCNVector3(Float.pi / 2, 0, 0)
        scene.rootNode.addChildNode(zAxisNode)
    }
    
    
}

extension SCNGeometry {
    
    class func cylinderLine(from: SCNVector3, to: SCNVector3,
                            segments: Int = 5, color: UIColor = UIColor.magenta, radius: CGFloat = 0.01) -> SCNNode {
        let x1 = from.x; let x2 = to.x
        let y1 = from.y; let y2 = to.y
        let z1 = from.z; let z2 = to.z
        
        let subExpr01 = Float((x2-x1) * (x2-x1))
        let subExpr02 = Float((y2-y1) * (y2-y1))
        let subExpr03 = Float((z2-z1) * (z2-z1))
        
        let distance = Float(sqrtf(subExpr01 + subExpr02 + subExpr03))
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(distance))
        cylinder.radialSegmentCount = segments
        cylinder.firstMaterial?.diffuse.contents = color
        
        let lineNode = SCNNode(geometry: cylinder)
        
        lineNode.position = SCNVector3((x1+x2)/2, (y1+y2)/2, (z1+z2)/2)
        
        lineNode.eulerAngles = SCNVector3(x: Float.pi / 2,
                                      y: acos((to.z-from.z)/distance),
                                      z: atan2((to.y-from.y), (to.x-from.x)))
        return lineNode
    }
}
