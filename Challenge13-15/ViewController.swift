import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(loadCountries), with: nil)
    }
    
    @objc func loadCountries() {
        let defaults = UserDefaults.standard
        let JSONDecoder = JSONDecoder()
        if let countriesToLoad = defaults.object(forKey: "countries") as? Data {
            do {
                countries = try JSONDecoder.decode([Country].self, from: countriesToLoad)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            } catch {
                print("Failed to load countries.")
            }
            
            if countries.isEmpty {
                if let url = Bundle.main.url(forResource: "countriesInfo", withExtension: "txt") {
                    if let countriesInfoString = try? String(contentsOf: url) {
                        let countriesInfo = countriesInfoString.components(separatedBy: "\n")
                        for countryInfo in countriesInfo {
                            let infoArray = countryInfo.components(separatedBy: " | ")
                            let country = Country(name: infoArray[0], capitalCity: infoArray[1], size: infoArray[2], population: infoArray[3], currency: infoArray[4], flag: infoArray[5])
                            countries.append(country)
                        }
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTableVC") as? DetailTableViewController {
            vc.currentCountry = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

