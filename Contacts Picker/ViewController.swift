//
//  ViewController.swift
//  EPContacts
//
//  Created by Prabaharan Elangovan on 12/10/15.
//  Copyright © 2015 Prabaharan Elangovan. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, EPPickerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onTouchShowMeContactsButton(_ sender: AnyObject) {
    
    let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:true, subtitleCellType: .phoneNumber)
    contactPickerScene.externalSourceDelegate = self
    let navigationController = UINavigationController(rootViewController: contactPickerScene)
    self.present(navigationController, animated: true, completion: nil)
    
  }
    
//MARK: EPContactsPicker delegates
    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error : NSError)
    {
        print("Failed with error \(error.description)")
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact)
    {
        print("Contact \(contact.displayName()) has been selected")
    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError)
    {
        print("User canceled the selection");
    }
    
    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts: [EPContact]) {
        print("The following contacts are selected")
        for contact in contacts {
            print("\(contact.displayName())")
        }
    }

}

extension ViewController: EPExternalSourceDelegate {
    
    func epExternalContactsSectionTitle() -> String {
        return "Users"
    }
    
    func epExternalContactsData() -> [CNContact] {
        let contact1 = CNMutableContact()
        contact1.familyName = "Test"
        contact1.givenName = "User1"
        contact1.phoneNumbers = [CNLabeledValue<CNPhoneNumber>(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: "12345690"))]
        
        let contact2 = CNMutableContact()
        contact2.familyName = "Test"
        contact2.givenName = "User2"
        contact2.phoneNumbers = [CNLabeledValue<CNPhoneNumber>(label:CNLabelPhoneNumberMain, value:CNPhoneNumber(stringValue: "12345690"))]
        
        return [contact1, contact2]
    }
    
    
}
