//
//  cityModel.swift
//  Lab4
//
//  Created by Melanie Hendricks on 2/27/20.
//  Copyright © 2020 Melanie Hendricks. All rights reserved.
//

import Foundation
class cities{
    
    var cities:[city] = []
    
    init(){
        let c1 = city(cn: "Tempe", cd: "Home of Arizona State University", cin: "tempe.jpg")
        let c2 = city(cn: "Denver", cd: "The city with the 2nd highest educated popuation in America.", cin: "denver.png")
        let c3 = city(cn: "Honolulu", cd: "Its home island of Oahu is part of the largest mountain range in the world, most of which is underwater. ", cin: "honolulu.jpg")
        let c4 = city(cn: "Las Vegas", cd: "Home of one of the largest Mormon populations in the world.", cin: "vegas.jpg")
        let c5 = city(cn: "Manhattan", cd: "The city that houses the Empire State Building, a building so big that it has its own zipcode.", cin: "manhattan.jpg")
        
        cities.append(c1)
        cities.append(c2)
        cities.append(c3)
        cities.append(c4)
        cities.append(c5)
    }
    
    
    // get count for number of rows in TableView
    func getCount() -> Int{
        return cities.count
    }
    
    // get city object at index
    func getCityObject(index: Int) -> city{
        return cities[index]
    }
    
    
    // add city to array
    func addCity(name:String, desc: String, image: String) -> city{
        let c = city(cn: name, cd: "The largest major US city that's not located on a navigable river.", cin: "indianapolis.jpg")
        cities.append(c)
        return c
    }
    
    // delete city from array
    func removeCity(index: Int){
        cities.remove(at: index)
    }
 
    
}

class city{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:String?
    
    init(cn:String, cd:String, cin:String){
        cityName = cn
        cityDescription = cd
        cityImageName = cin
    }
}
