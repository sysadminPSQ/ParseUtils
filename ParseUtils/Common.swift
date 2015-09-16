//
//  Common.swift
//  RoomAdvantage
//
//  Created by Akash on 28/05/15.
//  Copyright (c) 2015 pepper square. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

@IBDesignable
class FormTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
}

extension UIViewController
{
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func errorAnimation(errorField: UITextField!)
    {
        //This function uses the errorField parameter which takes a text field as the input
        
        //changes border color with specified color when error is encountered
        errorField.layer.borderWidth = 0.8
        errorField.layer.masksToBounds = true
        errorField.layer.borderColor = UIColor.redColor().CGColor
        
        //Shake animation if wrong values are entered in the textfields
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(errorField.center.x - 10, errorField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(errorField.center.x + 10, errorField.center.y))
        errorField.layer.addAnimation(animation, forKey: "position")
    }
    
    func validation(errorField: UITextField!, errorTitle: String!, errorMsg: String!) {
        
        // Create the alert controller
        var alertController = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .Alert)
        
        // Create the actions for OK, Cancel or even custom text of your choice
        
        var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            self.viewDidLoad()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alert(Title: String, errorMsg: String) {
        
        // Create the alert controller
        var alertController = UIAlertController(title: Title, message: errorMsg, preferredStyle: .Alert)
        
        // Create the actions for OK, Cancel or even custom text of your choice
        
        var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            //self.viewDidLoad()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func styleNextButton(buttonToStyle: UIButton) {
        
        buttonToStyle.layer.cornerRadius = 10.0
        buttonToStyle.layer.borderWidth = 1
        buttonToStyle.layer.borderColor = uicolorFromHex(0x0976b8).CGColor
    }
    func styleBackButton(buttonToStyle: UIButton) {
        
        buttonToStyle.layer.cornerRadius = 10.0
        buttonToStyle.layer.borderWidth = 1
        buttonToStyle.layer.borderColor = uicolorFromHex(0x818181).CGColor
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 10)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 10)
    }
    
    /* This function is to make sure that the view moves up and down relative to the keyboard hieght which tends to hide fields from view */
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    func disableButton(button: UIButton) {
        
        button.userInteractionEnabled = false
        
    }
    func enableButton(button: UIButton) {
        
        button.userInteractionEnabled = true
    }
    
    func styleImageView(imageView: UIImageView) {
        
        imageView.layer.borderWidth = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = uicolorFromHex(0xEEEEEE).CGColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleToFill
        
    }
    
}

class RAUtils {
    
    func styleImageView(image: UIImageView) {
        
        image.layer.borderWidth = 0.5
        image.layer.masksToBounds = false
        image.layer.borderColor = uicolorFromHex(0xEEEEEE).CGColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.contentMode = .ScaleToFill
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
}

extension UILabel {
    func resizeHeightToFit(heightConstraint: NSLayoutConstraint) {
        let attributes = [NSFontAttributeName : font]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.ByWordWrapping
        let rect = text!.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        heightConstraint.constant = rect.height
        setNeedsLayout()
    }
}