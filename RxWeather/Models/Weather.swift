//
//  Weather.swift
//  RxWeather
//
//  Created by max on 30.06.2022.
//

import Foundation

//struct Response: Codable {
//
//    let main: Weather
//
//}
//
//struct Weather: Codable {
//
//    let temp: Double
//    let humidity: Double
//
//}
//
//extension Response {
//    static var empty: Response {
//        return Response(main: Weather(temp: 0.0, humidity: 0.0))
//    }
//}

struct Response: Codable {
    let main: Main
}

struct Main: Codable {
    
    let temp: Double
    let humidity: Double
    
}

extension Response {
    static var empty: Response {
        return Response(main: Main(temp: 0.0, humidity: 0.0))
    }
}
