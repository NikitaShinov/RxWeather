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
