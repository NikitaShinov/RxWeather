import UIKit
import RxSwift


let disposeBag = DisposeBag()
    //MARK: - Start with

/*
 let numbers = Observable.of(2,3,4,5,6,7)

let observable = numbers.startWith(1)

observable.subscribe(onNext: {
    print ($0)
}).disposed(by: disposeBag)
*/

    //MARK: - Concat

/*
 let first = Observable.of(1,2,3,4)
let second = Observable.of(5,6,7)

let observable = Observable.concat([first, second])
observable.subscribe(onNext: {
    print ($0)
}).disposed(by: disposeBag)
*/

    //MARK: - Merge

/*
 let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(), right.asObservable())

let observable = source.merge()

observable.subscribe(onNext: {
    print ($0)
}).disposed(by: disposeBag)

left.onNext(1)
left.onNext(4)
right.onNext(2)
left.onNext(3)
right.onNext(80)
*/

    //MARK: - Combine Latest

/*
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
    "\(lastLeft) \(lastRight)"
}

let disposable = observable.subscribe(onNext: { value in
    print (value)
})

left.onNext(3)
left.onNext(5)
right.onNext(4)
left.onNext(0)
right.onNext(6)
right.onNext(9)
*/

    //MARK: - Latest from

/*
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable = button.withLatestFrom(textField)
let disposable = observable.subscribe(onNext: {
    print ($0)
})

textField.onNext("M")
textField.onNext("Mos")
textField.onNext("Moscow")

button.onNext(())
*/

    //MARK: - Reduce
/*
let source = Observable.of(1,2,3)

source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print ($0)
    }).disposed(by: disposeBag)
 
 let source = Observable.of("I "," love"," Swift!")

 source.reduce("", accumulator: +)
     .subscribe(onNext: {
         print ($0)
     }).disposed(by: disposeBag)

source.reduce(0, accumulator: {
    summary, newValue in
    return summary + newValue
}).subscribe(onNext: {
    print ($0)
}).disposed(by: disposeBag)
*/

    //MARK: - Scan

/*
let source = Observable.of(1,2,3,4)

source.scan(0, accumulator: +)
    .subscribe(onNext: {
        print ($0)
    }).disposed(by: disposeBag)
*/
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

var weather: Main?

func getData(of city: String, completion: @escaping(Main?) -> Void) {
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=e9bec230d54f533159f894c1420b75d9&units=metric")
    URLSession.shared.dataTask(with: url!) { data, _, error in
        guard let data = data, error == nil else { return }
        do {
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            weather = decodedData.main
            completion(weather)
        } catch {
            print (error.localizedDescription)
        }
    }.resume()
}

var temp = Double()
var hum = Double()

getData(of: "Moscow") { weather in
    guard let curWeather = weather else { return }
    temp = curWeather.temp
    hum = curWeather.humidity
}

