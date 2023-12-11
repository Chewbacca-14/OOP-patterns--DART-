import 'dart:async';

abstract class Observer {
  void updateCounter(int counter);
}

class CounterTwo implements Observer {
  @override
  void updateCounter(int counter) {
    int newCounter = counter + 1;
    print('count: $newCounter');
  }
}

class Counter implements Observer {
  @override
  void updateCounter(int counter) {
    print('cont: $counter');
  }
}

class MainCounter {
  int counter = 0;
  List<Observer> _observers = [];

  void startCounting() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      counter++;
      notifyObserver();
    });
  }

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void notifyObserver() {
    for (var observer in _observers) {
      observer.updateCounter(counter);
    }
  }
}

void observerPattern() {
  MainCounter mainCounter = MainCounter();
  Counter counter = Counter();
  CounterTwo counterTwo = CounterTwo();

  mainCounter.addObserver(counter);
  mainCounter.addObserver(counterTwo);

  mainCounter.startCounting();
}
