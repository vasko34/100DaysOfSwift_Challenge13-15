import UIKit

class DetailTableViewController: UITableViewController {
    var currentCountry: Country?
    var cellsInfo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentCountry = self.currentCountry {
            title = currentCountry.name
            cellsInfo = ["Flag", "Capital city: \(currentCountry.capitalCity)", "Size: \(currentCountry.size)", "Population: \(currentCountry.population)", "Currency: \(currentCountry.currency)"]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !cellsInfo.isEmpty else { fatalError("Couldn't load cell.")}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = cellsInfo[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard cellsInfo[indexPath.row] == "Flag" else { return }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            if let flag = currentCountry?.flag {
                vc.currentImage = flag
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
