//
//  DataModel.swift
//  WeatherForecast
//
//  Created by 신용철 on 2020/03/06.
//  Copyright © 2020 신용철 All rights reserved.
//

import UIKit
import CoreLocation

struct WeatherSummary: Decodable {
    let weather: Weather
    let result: Result
    
    struct Weather: Decodable {
        let minutely: [Minutely]
        
        struct Minutely: Decodable{
            
            let sky: Sky
            let temperature: Temperature
            
            struct Sky: Decodable{
                
                let code: String
                let name: String
            }
            struct Temperature: Decodable{
                let tc: String
                let tmax: String
                let tmin: String
            }
        }
    }
    
    struct Result: Decodable {
        let code: Int
        let message: String
    }
   
}

struct Forecast: Decodable {
    
    let weather: Weather
    let result: Result
    
    struct Weather: Decodable {
        let forecast3days: [Forecast3days]
        
        struct Forecast3days: Decodable {
            let fcst3hour: Fcst3hour
            
            struct Fcst3hour: Decodable {
                let sky: Sky
                let temperature: Temperature
                func arrayRepresentation() -> [ForecastData] {
                    var data: [ForecastData] = []
                    
                    for hour in stride(from: 4, to: 67, by: 3) {
                        var key = "code\(hour)hour"
                        guard let skyCode = sky.value(forKey: key) as? String else { continue }
                        
                        key = "name\(hour)hour"
                        guard let skyName = sky.value(forKey: key) as? String else { continue }
                        
                        key = "temp\(hour)hour"
                        guard let tempStr = temperature.value(forKey: key) as? String else { continue }
                        guard let temp = Double(tempStr) else { continue }
                        
                        let date = Date().addingTimeInterval(TimeInterval(hour) * 60 * 60)
                        
                        data.append(ForecastData(skyName: skyName, skyCode: skyCode, temperature: temp, date: date))
                    }
                    
                    return data
                }
            //key-value 값으로(String으로) for - in 반복문을 사용하여 프로퍼티의 값들을 가져오기 위해 @objcMembers class, NSObject 사용
              @objcMembers class Sky: NSObject, Decodable {
                let code4hour: String
                    let name4hour: String
                    let code7hour: String
                    let name7hour: String
                    let code10hour: String
                    let name10hour: String
                    let code13hour: String
                    let name13hour: String
                    let code16hour: String
                    let name16hour: String
                    let code19hour: String
                    let name19hour: String
                    let code22hour: String
                    let name22hour: String
                    let code25hour: String
                    let name25hour: String
                    let code28hour: String
                    let name28hour: String
                    let code31hour: String
                    let name31hour: String
                    let code34hour: String
                    let name34hour: String
                    let code37hour: String
                    let name37hour: String
                    let code40hour: String
                    let name40hour: String
                    let code43hour: String
                    let name43hour: String
                    let code46hour: String
                    let name46hour: String
                    let code49hour: String
                    let name49hour: String
                    let code52hour: String
                    let name52hour: String
                    let code55hour: String
                    let name55hour: String
                    let code58hour: String
                    let name58hour: String
                    let code61hour: String
                    let name61hour: String
                    let code64hour: String
                    let name64hour: String
                    let code67hour: String
                    let name67hour: String
                }
               @objcMembers class Temperature: NSObject, Decodable{
                    let temp4hour: String
                    let temp7hour: String
                    let temp10hour: String
                    let temp13hour: String
                    let temp16hour: String
                    let temp19hour: String
                    let temp22hour: String
                    let temp25hour: String
                    let temp28hour: String
                    let temp31hour: String
                    let temp34hour: String
                    let temp37hour: String
                    let temp40hour: String
                    let temp43hour: String
                    let temp46hour: String
                    let temp49hour: String
                    let temp52hour: String
                    let temp55hour: String
                    let temp58hour: String
                    let temp61hour: String
                    let temp64hour: String
                    let temp67hour: String
                }
            }
        }
    }
    
    struct Result: Decodable {
        let code: Int
        let message: String
    }
}

struct ForecastData {
    let skyName: String
    let skyCode: String
    let temperature: Double
    let date: Date
}

class WeatherDataSource {
    static let shared = WeatherDataSource()
    var summary: WeatherSummary?
    var forcastList: [ForecastData] = []
    
    let group = DispatchGroup()
    let queue = DispatchQueue(label: "que", attributes: .concurrent)
    
    
    func fetch(location: CLLocation, completion: @escaping () -> ()){
    
        group.enter()
        queue.async {
            self.fetchSummary(lat: location.coordinate.latitude, lon: location.coordinate.longitude, completion: {self.group.leave()})
        }
        
        group.enter()
        queue.async {
        self.fetchForcastList(lat: location.coordinate.latitude, lon: location.coordinate.longitude, completion: {self.group.leave()})
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    
    func fetchSummary(lat: Double, lon: Double, completion: @escaping ()->()){
        
        let apiUrl = "https://apis.openapi.sk.com/weather/current/minutely?version=2&lat=\(lat)&lon=\(lon)&appKey=l7xxc085acf248ff4ae38c2f6eb09f53adc9"

        let url = URL(string: apiUrl)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            
            guard error == nil else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200...299
            guard successRange.contains(statusCode) else { return }
            
            guard let data = data else { return }
            
            do{
                let summary = try JSONDecoder().decode(WeatherSummary.self, from: data)
                self.summary = summary
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchForcastList(lat: Double, lon: Double, completion: @escaping ()->()){
        let apiUrl = "https://apis.openapi.sk.com/weather/forecast/3days?version=2&lat=\(lat)&lon=\(lon)&appKey=l7xxc085acf248ff4ae38c2f6eb09f53adc9"

        let url = URL(string: apiUrl)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            
            guard error == nil else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200...299
            guard successRange.contains(statusCode) else { return }
            
            guard let data = data else { return }
            
            do{
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                if let list = forecast.weather.forecast3days.first?.fcst3hour.arrayRepresentation() {
                    self.forcastList = list
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
