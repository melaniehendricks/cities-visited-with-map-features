//
//  ViewController.swift
//  Lab4
//
//  Created by Melanie Hendricks on 2/27/20.
//  Copyright © 2020 Melanie Hendricks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // declare variables
    @IBOutlet weak var cityTable: UITableView!
    
    // model
    var myCityList:cities = cities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // data source method: how many rows are in the table
    // will be called while loading the app
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return myCityList.getCount()
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        // call city model to get the city object for each row
        let cityItem = myCityList.getCityObject(index: indexPath.row)
        cell.cityTitle.text = cityItem.cityName
        cell.cityImage.image = UIImage(named: cityItem.cityImageName!)
        
        return cell
        
    }
    
    // delegate method to make cells bigger
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    
    // enables rows to be deleted by swiping the row from right to left
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //
    func tableView(_ tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle{
        return UITableViewCell.EditingStyle.delete
    }
    
    
    // delete a city, change model, reload the updated table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        // delete data from city table
        myCityList.removeCity(index: indexPath.row)
        
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
    }
    
    
      // add new city, change model, reload table
    @IBAction func addCity(_ sender: AnyObject) {
        
         let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         
         alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter the name of the city here"
         })
         
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
         // if there is text in textfield,
         if let name = alert.textFields?.first?.text{
            self.myCityList.addCity(name: name, desc: "Hilary", image: "indianapolis.jpg")
         
         let indexPath = IndexPath(row: self.myCityList.getCount() - 1, section: 0)
         self.cityTable.beginUpdates()
         self.cityTable.insertRows(at: [indexPath], with: .automatic)
         self.cityTable.endUpdates()
         
            }
         }))
         
        self.present(alert, animated: true)
         
    }
    
    // go to detail view through the segue when user selects a table row
      override func prepare(for segue: UIStoryboardSegue, sender: Any?){
          let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
          
          let city = myCityList.getCityObject(index: selectedIndex.row)
          
          // if segue identifier is "detailView"
          // pass selected city to DetailViewController
          if(segue.identifier == "detailView"){
              if let viewController: DetailViewController = segue.destination as? DetailViewController{
                  viewController.selectedCity = city.cityName                
              }
          }
      }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    

}

