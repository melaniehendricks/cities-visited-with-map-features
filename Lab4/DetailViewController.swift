//
//  DetailViewController.swift
//  Lab4
//
//  Created by Melanie Hendricks on 2/27/20.
//  Copyright © 2020 Melanie Hendricks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // declare variables
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityPicture: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityDesc: UITextView!
    var selectedCity:String?
    var cityImageName:String?
    var desc:String?
    
    
    // NEED IMAGE AND DESCRIPTION VARIABLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityLabel.text = selectedCity
        self.cityPicture.image = UIImage(named: cityImageName!)
        //self.cityDescription.text = desc
        self.cityDesc.text = desc

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
