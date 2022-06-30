//
//  ViewController.swift
//  RxWeather
//
//  Created by max on 30.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(of: city)
                    }
                }
            }).disposed(by: disposeBag)

    
    }
    
    private func displayWeather(_ weather: Main?) {
        
        if let weather = weather {
            self.tempLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 💧"
        } else {
            self.tempLabel.text = "🤔"
            self.tempLabel.text = "🙈"
        }
    }
    
    private func fetchWeather(of city: String) {
        guard let url = URL.weatherURL(city: city) else {
                  return
              }
        let resource = Resource<Response>(url: url)

        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .retry(3)
            .catch { error in
                print (error.localizedDescription)
                return Observable.just(Response.empty)
            }.asDriver(onErrorJustReturn: Response.empty)
        
        search.map { "\($0.main.temp) ℉"}
        .drive(self.tempLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💧"}
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag)
    }


}

