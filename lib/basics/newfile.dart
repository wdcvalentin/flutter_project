void main(List<String> arguments) {
  String type = 'bike';

  Vehicle(type); // => Bike()
}

abstract class Vehicle {
  int _speed;
  final int capacity;

  factory Vehicle(String type) {
    if (type == 'bike') {
      return Bike();
    } else if (type == 'car') {
      return Car();
    } else {
      throw Exception();
    }
  }

  Vehicle._(this.capacity) : _speed = 0;

  int get speed => _speed;

  void speedUp(int speed) {
    this._speed += speed;
    this._speed = this._speed + speed;
  }

  String operator <=(Object other) => 'test';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vehicle &&
          runtimeType == other.runtimeType &&
          _speed == other._speed &&
          capacity == other.capacity;

  @override
  int get hashCode => _speed.hashCode ^ capacity.hashCode;
}

class Bike extends Vehicle {
  Bike() : super._(1);
}

class Car extends Vehicle {
  Car() : super._(4);
}
