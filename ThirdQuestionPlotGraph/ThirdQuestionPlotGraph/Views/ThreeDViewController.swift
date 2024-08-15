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
        
        // Setup the camera distance from origin on z axis
        let cameraDistance: Float = 5

        setupSceneEnvironment(cameraDistance: cameraDistance, to: scene)
        
        // Allow user to manipulate the camera
        sceneView.allowsCameraControl = true
        // Add data points
        let data = KeypointsHelper.readLocalFile(forName: "CA_Keypoints")
        let dataPoints = data.map {$0.get3DCoordinate()}

        addCylinderThroughDataPoints(dataPoints, to: scene)

    }
    
    func setupSceneEnvironment(cameraDistance: Float = 3, to scene: SCNScene) {
        
        // Setup the camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: cameraDistance)
        scene.rootNode.addChildNode(cameraNode)
        
        // Add floor to the scene
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

    
    
    func addCylinderThroughDataPoints(_ vertices: [SCNVector3], to scene: SCNScene) {
        for i in 0..<vertices.count - 1 {
            scene.rootNode.addChildNode(SCNGeometry.cylinderLine(from: vertices[i], to: vertices[i + 1]))
        }
    }
}
