//
//  ViewController.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 13/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var twoDButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3A. 2D Coordinate", for: .normal)
        button.addTarget(self, action: #selector(twoDButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var threeDButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3B. 3D Coordinate", for: .normal)
        button.addTarget(self, action: #selector(threeDButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.title = "Third Question"
        view.addSubview(twoDButton)
        twoDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twoDButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        view.addSubview(threeDButton)
        threeDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        threeDButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
    }
    
    @objc func twoDButtonTapped() {
        if let navigate = self.navigationController {
            navigate.pushViewController(TwoDViewController(), animated: true)
        } else {
            print("navigation controller nil")
        }
    }
    
    @objc func threeDButtonTapped() {
        if let navigate = self.navigationController {
            navigate.pushViewController(ThreeDViewController(), animated: true)
        } else {
            print("navigation controller nil")
        }
    }

}
