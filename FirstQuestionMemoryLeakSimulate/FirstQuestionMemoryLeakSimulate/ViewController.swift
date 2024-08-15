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
        
        let dispatchGroup = DispatchGroup()

        let queue = DispatchQueue.global(qos: .userInitiated)

        // Task 1
        dispatchGroup.enter()
        queue.async {
            doTask1()
            print("Task 1 complete")
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("All tasks complete. Starting Task 3.")
            doTask3()
        }
        // Task 2
        dispatchGroup.enter()
        queue.async {
            doTask2()
            print("Task 2 complete")
            dispatchGroup.leave()
        }
        dispatchGroup.no
        // Notify when all tasks are complete
        
        

        // Function Definitions (For Example)
        func doTask1() {
            // Simulate work
            sleep(2)
        }

        func doTask2() {
            // Simulate work
            sleep(1)
        }

        func doTask3() {
            // Simulate work
            print("Task 3 is now running.")
        }
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
    var main: MainClass?
    
    init (main: MainClass) {
        self.main = main
        self.main?.add(sub: self)
    }
    
    deinit {
        print("\(Self.self) object was deallocated")
    }
}
