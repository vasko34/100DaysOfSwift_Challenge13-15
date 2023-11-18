import UIKit

class Country: NSObject, Codable {
    var name: String
    var capitalCity: String
    var size: String
    var population: String
    var currency: String
    var flag: String
    
    init(name: String, capitalCity: String, size: String, population: String, currency: String, flag: String) {
        self.name = name
        self.capitalCity = capitalCity
        self.size = size
        self.population = population
        self.currency = currency
        self.flag = flag
    }
}
