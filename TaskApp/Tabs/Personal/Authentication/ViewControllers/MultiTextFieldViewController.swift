//
//  MultiTextFieldViewController
//  TaskApp
//
//  Created by Spencer Michaels on 2016/3/28.
//  Copyright © 2016年 Cameric. All rights reserved.
//

import UIKit

class MultiTextFieldViewController: UIViewController, UITextFieldDelegate {
    var whitelistedViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // TODO: Is this the right check to make?
        // If the first touch was anywhere other than inside a whitelisted field, dismiss the keyboard
        
        if !whitelistedViews.contains({ (whitelisted: AnyObject) -> Bool in
            return (touches.first?.view) == (whitelisted as? UIView)
        }) {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent: event)
    }
}
