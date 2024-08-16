//
//  ViewController.swift
//  FirstQuestionMemoryLeakSimulate
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Navigate", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped() {
        if let navigate = self.navigationController {
            navigate.pushViewController(SecondViewController(), animated: true)
        } else {
            print("navigation controller nil")
        }
    }
    
}

class SecondViewController: UIViewController {
    
    let main = MainClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        main.add(sub: SubClass(main: main))
        
    }
    
    deinit {
        print("\(Self.self) object was deallocated")
    }
}

class MainClass {
    var subs: [SubClass] = []
    func add(sub: SubClass) {
        subs.append(sub)
    }
    
    deinit {
        print("\(Self.self) object was deallocated")
    }
}

class SubClass {
    weak var main: MainClass?
    
    init (main: MainClass) {
        self.main = main
        self.main?.add(sub: self)
    }
    
    deinit {
        print("\(Self.self) object was deallocated")
    }
}
