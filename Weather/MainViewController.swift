//
//  MainViewController.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/28.
//  Copyright © 2018 Over. All rights reserved.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    private var weatherProvider: WeatherProvider
    private var weather: WeatherDisplay?
    private var city: City
    
    private let tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .black
        t.backgroundView = BlackView()
        t.tableFooterView = UIView()
        return t
    }()
    
    init(city: City) {
        weatherProvider = WeatherProvider(city: city)
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = title(for: city)
        
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "Cell")
        tableView.alpha = 0
        
        
        let animationView = LOTAnimationView(name: "snap_loader_white", bundle: Bundle(for: MainViewController.self))
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        animationView.center = view.center


        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        
        animationView.loopAnimation = false
        
        animationView.play { [weak self] _ in
//            animationView.play(completion: { _ in
            
            UIView.animate(withDuration: 0.3, animations: {
                self?.tableView.alpha = 1
            })
            
            animationView.isHidden = true

//            })
        }
        
        weatherProvider.delegate = self
        
    }
    
    private func title(for city: City) -> String {
        switch city {
        case .capetown:
            return "Cape Town"
        case .berlin:
            return "Berlin"
        case .tokyo:
            return "Tokyo"
        }
    }
    
}

class BlackView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        guard let weather = weather else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Condition:"
            cell.valueLabel.text = weather.description
            cell.icon.image = #imageLiteral(resourceName: "Condution")
        case 1:
            cell.titleLabel.text = "Current Temp:"
            cell.valueLabel.text = "\(String(describing: weather.currentTemperature))°C"
            cell.icon.image = #imageLiteral(resourceName: "Temp")
        case 2:
            cell.titleLabel.text = "Humidity:"
            cell.valueLabel.text = "\(String(describing: weather.humidity))%"
            cell.icon.image = #imageLiteral(resourceName: "Humidity")
        case 3:
            cell.titleLabel.text = "Pressure:"
            cell.valueLabel.text = "\(String(describing: weather.pressure))"
            cell.icon.image = #imageLiteral(resourceName: "Pressure")
        case 4:
            cell.titleLabel.text = "Wind:"
            cell.valueLabel.text = "\(String(describing: weather.windSpeed))km/h"
            cell.icon.image = #imageLiteral(resourceName: "WindSpeed")
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .black
    }
}

extension MainViewController: WeatherProviderDelegate {
    func weatherProvider(didUpdateWeatherData weather: WeatherDisplay) {
        self.weather = weather
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

class WeatherCell: UITableViewCell {
    
    let icon: UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFit
        l.widthAnchor.constraint(equalToConstant: 30).isActive = true
        l.heightAnchor.constraint(equalToConstant: 30).isActive = true
        l.translatesAutoresizingMaskIntoConstraints = false
        l.tintColor = .white
        return l
    }()

    let titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let valueLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.white
        return l
    }()
    

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        textLabel?.textColor = .white
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(valueLabel)

        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: 8).isActive = true
        
        valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
