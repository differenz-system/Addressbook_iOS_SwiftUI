//
//  Utilities.swift
//  AddressBook
//
//  Created by DifferenzSystem PVT. LTD. on 01/21/21.
//  Copyright © 2021 Differenz System. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    /**
     This method is used to check internet connectivity.
        - Returns: Return boolean value to indicate device is connected with internet or not
     */
    static func checkInternetConnection() -> Bool {
        if(APIManager.isConnectedToNetwork()) {
            return true
        }
        else {
            return false
        }
    }
    
    /**
     This method is used to know current device is iPad or not.
        - Returns: Return boolean value to indicate device is iPad or not
     */
    class func isDeviceiPad() -> Bool  {
        // Return DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /**
     This method is used to show alert.
        - Parameters:
            - msg: Message that needs to dispaly with alert
            - vc: Object of UIViewController from which you want to show alert
     */
    static func showAlert(msg : String , vc : UIViewController) {
        let alert = UIAlertController(title: "Message", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true)
    }
}

