//
//  Menu.swift
//  Health-Swift
//
//  Created by Simon Bessey on 26/05/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit  


class Menu: UIViewController {
    
    func showatfirst(){
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "Great!", message: "Remeber to fill in your medical data- we cannot accurately monitor until this is complete!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}

        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidAppear(animated: Bool){
        //        let status = medicalStatus.count
        //
        //        if(status == 0){
        //            showatfirst()
        //        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

