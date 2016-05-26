//
//  BLEdevices.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

 
import UIKit

class BLEdevices: UIViewController {
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBOutlet weak var scanner: UIActivityIndicatorView!
    @IBAction func scan(sender: AnyObject) {
        scanner.startAnimating()
        delay(1.5){
            self.scanner.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
