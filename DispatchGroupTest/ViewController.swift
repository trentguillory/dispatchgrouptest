//
//  ViewController.swift
//  DispatchGroupTest
//
//  Created by Trent Guillory on 3/15/18.
//  Copyright © 2018 Trent Guillory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mockAPI: MockAPI = MockAPI()
    let dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func printValues() {
        DispatchQueue.global().async {
            let currencyString: (String) -> Void = { currStr in
                print(currStr)
            }
            
            self.currencyStringFromAPI(api: self.mockAPI, completionHandler: currencyString)
        }
    }
    
    func currencyStringFromAPI(api: MockAPI, completionHandler: (String) -> Void) {
        
        var dollars: Int?
        var cents: Int?
        
        // Mock Dollar Request With Wait Time
        let randomLoadTimeD = arc4random_uniform(5)
        dispatchGroup.enter()
        print("Starting task 1")
        delay(bySeconds: Double(randomLoadTimeD), dispatchLevel: .background) {
            dollars = api.getDollars()
            print("Ending task 1")
            self.dispatchGroup.leave()
        }
        
        // Mock Cents Request With Wait Time
        let randomLoadTimeC = arc4random_uniform(5)
        dispatchGroup.enter()
        print("Starting task 2")
        delay(bySeconds: Double(randomLoadTimeC), dispatchLevel: .background) {
            cents = api.getCents()
            print("Ending task 2")
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
        
        completionHandler(String("Dollars: \(String(describing: dollars)), Cents: \(String(describing: cents))"))
    }

}

