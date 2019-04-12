//
//  ViewController.swift
//  MA18Threads
//
//  Created by David Svensson on 2019-04-05.
//  Copyright © 2019 David Svensson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var inactiveQueue: DispatchQueue!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // simpleQueue()
        
      //  queuesWithPriority()
        
       // concurrentQueue()
       // print("kön skapad")
      //  inactiveQueue.activate()
        
      // deleyedQueue()
        fetchImage()
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        for i in 0...10000000 {
//
//            print("🍎 \(i)")
//
//        }
//    }

    func simpleQueue() {
        
        let queue = DispatchQueue(label: "myQueue")
        
        queue.async {
            for i in 0...10 {
                print("🍎 \(i)")
//                if Thread.current.isMainThread {
//                    print("🍎 main")
//                }
                
            }
        }
        
        for i in 0...10 {
            print("🍏 \(i)")
//            if Thread.current.isMainThread {
//                print("🍏 main")
//            }
        }

    }
    
    
    func queuesWithPriority() {
        let queue1 = DispatchQueue(label: "queue1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "queue2", qos: .utility)
        
        
        queue1.async {
            for i in 0...10 {
                 print("🍎 \(i)")
            }
        }
        
        queue2.async {
            for i in 0...10 {
                print("🍏 \(i)")
            }
        }
        
        for i in 0...10 {
            print("🍊 \(i)")
        }
        
    }
    
    func concurrentQueue() {
        let queue = DispatchQueue(label: "queue", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        inactiveQueue = queue
        
        queue.async {
            for i in 0...10 {
                print("🍎 \(i)")
            }
        }
        
        queue.async {
            for i in 0...10 {
                print("🍏 \(i)")
            }
        }
        
        queue.async {
            for i in 0...10 {
                print("🍊 \(i)")
            }
        }
    }
    
    
    func deleyedQueue() {
        let queue = DispatchQueue(label: "queue", qos: .userInitiated)
        
        print("🍊")
        
        queue.asyncAfter(deadline: .now() + 3) {
            print("🍏")
        }
    }
    
    
    func fetchImage() {
        guard let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/69/June_odd-eyed-cat_cropped.jpg") else {return}
        
        
        
        URLSession(configuration: .default).dataTask(with: imageUrl, completionHandler: {
            (imageData, response, error) in
            
            if let data = imageData {
                print("Bild nedladdad 🍊")
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
        print("bild start 🍏")
        
        
        
    }
    
    

}

