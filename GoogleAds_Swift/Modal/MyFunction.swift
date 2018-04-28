//
//  MyFunction.swift
//  MyNotes
//
//  Created by Bhargav on 09/09/17.
//  Copyright © 2017 wos. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SystemConfiguration

class MyFunction: NSObject {
    func showAlertMessage(_ Message: String, _ AutoHide:Bool) -> Void
    {
        let alert = UIAlertController(title: Message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        if AutoHide == true
        {
            //alert.dismiss(animated: true, completion:nil)
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime)
            {
                //print("Alert Dismiss")
                alert.dismiss(animated: true, completion:nil)
            }
        }
        else
        {
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        }
        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func getRandomColor() -> UIColor
    {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.35)
    }
    
    func setCornerRadius(_ Layer: CALayer, _ RadiusValue:CGFloat) -> Void
    {
        Layer.cornerRadius = RadiusValue
        Layer.masksToBounds = true
    }
    
    func setBorderWidth(_ Layer: CALayer, _ WidthValue:CGFloat, BorderColor:UIColor) -> Void
    {
        Layer.borderColor = BorderColor.cgColor
        Layer.borderWidth = WidthValue
        Layer.masksToBounds = true
    }
}
