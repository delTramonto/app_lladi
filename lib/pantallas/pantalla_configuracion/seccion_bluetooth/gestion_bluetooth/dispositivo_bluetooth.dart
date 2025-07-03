import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DispositivoBluetooth {
  final BluetoothDevice dispositivo;

  EstadoDispositivo _estado = EstadoDispositivo.desconectado;

  DispositivoBluetooth({required this.dispositivo, EstadoDispositivo? estado}) {
    if (estado != null) {
      _estado = estado;
    }
  }

  EstadoDispositivo get estado => _estado;

  void asignarEstado(EstadoDispositivo estado) => _estado = estado;

  String get direccion => dispositivo.address;

  String? get nombre => dispositivo.name;
}

enum EstadoDispositivo {
  conectado,
  conectando,
  desconectado,
  desconectando,
  emparejado,
  emparejando,
}
