//
//  GalleryViewController.swift
//  SpecialTopicProject
//
//  Created by Preethi Srinivasan on 11/28/17.
//  Copyright © 2017 Prajakta Morale. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getImage(imageName: "test.png")
        //getImage(imageName: "test.png")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func getImage(imageName: String){
        //let fileManager = FileManager.default
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(imageName)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
       // if fileManager.fileExists(atPath: imagePath){
           imageView.image = UIImage(contentsOfFile: imageName)
            
            //new code
        }else{
            print("Panic! No Image!")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

