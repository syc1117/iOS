import UIKit
import Foundation


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

let apiUrl = "https://apis.openapi.sk.com/weather/current/minutely?version=2&lat=37.498206&lon=127.02761&appKey=l7xxc085acf248ff4ae38c2f6eb09f53adc9"

let url = URL(string: apiUrl)!

URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard error == nil else { return }
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200...299
    guard successRange.contains(statusCode) else { return }
    
    guard let data = data else { return }
    
    do{
        let summary = try JSONDecoder().decode(WeatherSummary.self, from: data)
        summary.result.code
        summary.weather.minutely.first?.sky.code
        summary.weather.minutely.first?.sky.name
        
        summary.weather.minutely.first?.temperature.tc
        summary.weather.minutely.first?.temperature.tmax
        summary.weather.minutely.first?.temperature.tmin
    } catch {
        print(error.localizedDescription)
    }
}.resume()
