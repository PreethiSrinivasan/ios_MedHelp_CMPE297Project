//
//  DBViewController.swift
//  SpecialTopicProject
//
//  Created by Prajakta Morale on 12/8/17.
//  Copyright © 2017 Prajakta Morale. All rights reserved.
//

import UIKit
import SQLite3

class DBViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pillName: UITextField!
    
    @IBOutlet weak var pillUsage: UITextView!
    
    @IBOutlet weak var pillQuantity: UITextField!
    
    @IBOutlet weak var pillShape: UITextField!
    
    @IBOutlet weak var pillColor: UITextField!
    let manager = FileManager.default
    var dbPath:String? = nil
    
    override func viewDidLoad() {
        self.pillName.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentDirectory = try! manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // create the destination url for the text file to be saved
        let fileURL = documentDirectory.appendingPathComponent("pills.db")
        
        
        //let fileURL = databasePath()
        print("db path : " + fileURL.path)
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if manager.fileExists(atPath: fileURL.path) {
            if sqlite3_exec(db, "create table if not exists pills (pillName text, pillUsage text, pillQuantity text, pillShape text, pillColor text)", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error creating table: \(errmsg)")
            }
        } else {
            print("error creating database")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        
        var db: OpaquePointer?
        
        let fileURL = databasePath()
        print("db path : " + fileURL)
        
        if manager.fileExists(atPath: fileURL) {
            
            if sqlite3_open(fileURL, &db) != SQLITE_OK {
                print("error opening database")
            }
            
            let insertstmt = "insert into pills (pillName, pillUsage, pillQuantity, pillShape, pillColor) values ('" + pillName.text! + "','" + pillUsage.text! + "', '" + pillQuantity.text! + "', '" + pillShape.text! + "', '" + pillColor.text! + "')"
            if sqlite3_exec(db, insertstmt, nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error inserting data \(errmsg)")
            }
        }
    }
    
    
    @IBAction func clearText(_ sender: Any) {
        pillName.text=""
        pillUsage.text = ""
        pillQuantity.text=""
        pillShape.text=""
        pillColor.text=""
    }
    
    func databasePath() -> String
    {
        
        let documentDirectory = try! manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        // create the destination url for the text file to be saved
        let fileURL = documentDirectory.appendingPathComponent("pills.db")
        
        if manager.fileExists(atPath: fileURL.path) {
            return fileURL.path as String
        }
        return fileURL.path as String
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Press return key function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pillName.resignFirstResponder()
        return(true)
    }
    
}


