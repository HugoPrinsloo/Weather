//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/28.
//  Copyright © 2018 Over. All rights reserved.
//

import UIKit

class CitySelectionViewController: UIViewController {
    
    private enum SupportedCity {
        case capetown
        case berlin
        case tokyo
        
        var title: String {
            switch self {
            case .capetown:
                return "Cape Town"
            case .berlin:
                return "Berlin"
            case .tokyo:
                return "Tokyo"
            }
        }
        
        var icon: UIImage {
            switch self {
            case .capetown:
                return #imageLiteral(resourceName: "CapeTown")
            case .berlin:
                return #imageLiteral(resourceName: "Berlin")
            case .tokyo:
                return #imageLiteral(resourceName: "Tokyo")
            }
        }
        
        var city: City {
            switch self {
            case .capetown:
                return .capetown
            case .berlin:
                return .berlin
            case .tokyo:
                return .tokyo
            }

        }
    }
    
    private let tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .black
        t.backgroundView = BlackView()
        t.tableFooterView = UIView()
        return t
    }()

    private let items: [SupportedCity] = [.capetown, .berlin, .tokyo]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = .black
        
        title = "Select City"
        
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.register(WeatherCell.self, forCellReuseIdentifier: "Cell")
        
        navigationController?.navigationBar.tintColor = .white

    }

}

extension CitySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.icon.image = item.icon
        cell.selectionStyle = .none

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .black
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MainViewController(city: items[indexPath.row].city)
        navigationController?.pushViewController(vc, animated: true)
    }
}
