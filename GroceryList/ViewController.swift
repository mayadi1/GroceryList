//
//  ViewController.swift
//  GroceryList
//
//  Created by Mohamed Ayadi on 10/1/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var nItem: List? = nil
    
    
    @IBOutlet weak var entryItem: UITextField!
    @IBOutlet weak var entryQty: UITextField!
    @IBOutlet weak var entryNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if nItem != nil {
            entryItem.text = nItem?.item
            entryQty.text = nItem?.qty
            entryNote.text = nItem?.note
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        // dismiss view controller and return to list
        dismissVC()
    }

    @IBAction func saveTapped(sender: UIBarButtonItem) {
        // save data to core data
        
        if nItem != nil {
            editItem()
        } else {
            newItem()
        }
        
        // dismiss view controller
        dismissVC()
        
    }
    
    func newItem() {
        let context = self.context
        let ent = NSEntityDescription.entityForName("List", inManagedObjectContext: context)
        let nItem = List(entity: ent!, insertIntoManagedObjectContext: context)
        nItem.item = entryItem.text
        nItem.qty = entryQty.text
        nItem.note = entryNote.text
        
        do {
            try context.save()
            print(nItem)
        } catch _ {
            print("Error saving context.")
        }
    }
    
    func editItem() {
        nItem?.item = entryItem.text
        nItem?.qty = entryQty.text
        nItem?.note = entryNote.text
        
        do {
            try context.save()
            print(nItem)
        } catch _ {
            print("Error saving context.")
        }
    }
    
    func dismissVC() {
        navigationController?.popViewControllerAnimated(true)
    }
}

