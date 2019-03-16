//
//  ViewController.swift
//  projet_weather
//
//  Created by ESTS on 07/03/2019.
//  Copyright © 2019 ESTS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var view_principal: UIView!
    @IBOutlet var area: UIView!
    
    //varibales
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var lieu: UILabel!
    @IBOutlet weak var temperateur: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var humidite: UILabel!
    @IBOutlet weak var tem_max: UILabel!
    @IBOutlet weak var tem_min: UILabel!
    @IBOutlet weak var wid: UILabel!
    
    
    let apiKey:String = "b1f13b028543cae8e22cec8bac3fa353"
    let ville:String = "Rabat,ma"
    
    let url:String = "http://api.openweathermap.org/data/2.5/weather?q=Rabat,ma&appid=bebd235ab651c2a616369261b6bc97d4&units=metric&lang=fr"
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_principal.backgroundColor = UIColor.white
        area.backgroundColor = UIColor.white
        ///date_time
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        let todaysDate = dateFormatter.string(from: date)
        dateTime.text = String(todaysDate)
        
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Rabat,ma&appid=bebd235ab651c2a616369261b6bc97d4&units=metric&lang=fr")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data
                {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                        print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary
                        {
                            if let temperature = mainDictionary.value(forKey: "temp")
                            {
                                DispatchQueue.main.async
                                    {
                                  //  print("Atlanta Temperature: \(temperature)°F")
                                    self.temperateur.text = "\(temperature) °C"
                                    
                                    }
                            }
                            if let humidite = mainDictionary.value(forKey: "humidity")
                            {
                                DispatchQueue.main.async
                                    {
                                        //  print("Atlanta Temperature: \(temperature)°F")
                                        self.humidite.text = "humidite \(humidite) %"
                                        
                                }
                            }
                            if let temmax = mainDictionary.value(forKey: "temp_max")
                            {
                                DispatchQueue.main.async
                                    {
                                        //  print("Atlanta Temperature: \(temperature)°F")
                                        self.tem_max.text = "temp_max \(temmax) °C"
                                        
                                }
                            }
                            if let temmin = mainDictionary.value(forKey: "temp_min")
                            {
                                DispatchQueue.main.async
                                    {
                                        //  print("Atlanta Temperature: \(temperature)°F")
                                        self.tem_min.text = "temp_min \(temmin) °C"
                                        
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                        
                        if let nameCity = jsonObj!.value(forKey: "name") as? String
                        {
                            DispatchQueue.main.async
                            {
                                   self.lieu.text = nameCity
                            }
                        }
                        if let mainDictionary = jsonObj!.value(forKey: "weather") as? [[String: Any]]
                        {
                            guard let weather_content = mainDictionary[0] as? [String:Any] else { return }
                            
                            
                            guard let icon = weather_content["icon"] as? String else { return }
                            
                            DispatchQueue.main.async
                                {
                                    
                                    print("\(icon)")
                                    self.img.image = UIImage(named: "\(icon)")
                                    
                            }
                            if let wd = jsonObj!.value(forKey: "wind") as? NSDictionary
                            {
                                if let spd = wd.value(forKey: "speed")
                                {
                                    DispatchQueue.main.async
                                        {
                                            //  print("Atlanta Temperature: \(temperature)°F")
                                            self.wid.text = "wind  speed :\(spd) m/s "
                                            
                                    }
                                }
                            }
                           
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                        
                    }
                    else
                    {
                        print("Error: unable to convert json data")
                    }
                }
                else
                {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()

        
    }
   
   

}

