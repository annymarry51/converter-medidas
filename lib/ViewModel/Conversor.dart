import 'package:flutter/material.dart';

class Conversor extends ChangeNotifier {

  TextEditingController toText = TextEditingController();
  TextEditingController fromText = TextEditingController();

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  double celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  conversor(double value, String fromUnit, String toUnit) {
    double result = 0.0;

    if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
      result = celsiusToFahrenheit(value);
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
      result = fahrenheitToCelsius(value);
    } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
      result = celsiusToKelvin(value);
    } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
      result = value - 273.15;
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Kelvin') {
      result = celsiusToKelvin(fahrenheitToCelsius(value));
    } else if (fromUnit == 'Kelvin' && toUnit == 'Fahrenheit') {
      result = celsiusToFahrenheit(value - 273.15);
    } else {
      // If the units are the same, return the original value
      result = value;
    }

    return result;
  }
}