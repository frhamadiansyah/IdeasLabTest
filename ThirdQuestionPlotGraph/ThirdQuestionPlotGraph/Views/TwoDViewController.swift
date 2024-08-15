//
//  TwoDViewController.swift
//  ThirdQuestionPlotGraph
//
//  Created by Fandrian Rhamadiansyah on 14/08/24.
//

import UIKit

class TwoDViewController: UIViewController {
    
    lazy var graph: GraphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(graph)
        graph.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graph.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        graph.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        graph.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true


    }


}
