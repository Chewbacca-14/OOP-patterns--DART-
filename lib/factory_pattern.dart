abstract interface class Transport {
  String getModel();
  void start();
}

class Bike extends Transport {
  @override
  String getModel() {
    return 'GSR 600';
  }

  @override
  void start() {
    print('Bike started wroom wroom...');
  }
}

class Car implements Transport {
  @override
  String getModel() {
    return 'Cybertruck';
  }

  @override
  void start() {
    print('bzzzz bzzzz...');
  }
}

abstract interface class TransportFactory {
  Transport createTransport();
}

class BikeFactory implements TransportFactory {
  @override
  Transport createTransport() {
    return Bike();
  }
}

class CarFactory implements TransportFactory {
  @override
  Transport createTransport() {
    return Car();
  }
}

void factoryPattern() {
  TransportFactory bikeFactory = BikeFactory();
  Transport bike = bikeFactory.createTransport();
  print(bike.getModel());
  bike.start();
  TransportFactory carFactory = CarFactory();
  Transport car = carFactory.createTransport();
  print(car.getModel());
  car.start();
}
