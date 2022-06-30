//
//  URL + Ext.swift
//  RxWeather
//
//  Created by max on 30.06.2022.
//

import Foundation

extension URL {
    
    static func weatherURL(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(Constants.apikey)&units=imperial")
    }
}
