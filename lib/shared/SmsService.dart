import 'package:app/shared/EnvioSMS.dart';
import 'package:dio/dio.dart';

class SmsService {
  
  Dio client;

  SmsService() {
    this.client = Dio();
  }

  Future<EnvioSMS> enviar(String telefone) async {
    try {
      EnvioSMS retorno;
      var response = await client.post(
        "https://sms.comtele.com.br/api/v2/tokenmanager",
        data: {
          "PhoneNumber": telefone, "Prefix": "Leandro Mendes te manda um abraco"
        },
        options: Options(
          headers: {
            "auth-key": "e6e85810-046d-4afd-9b3d-e34e883e6c63",
            "content-type": "application/json"
          }
        )
      );
      if (response.statusCode == 200) {
        retorno = EnvioSMS.fromJson(response.data);
        print(response.data);
      }

      return retorno;
    } catch (e) {
      print(e);
      throw e;
    }
  }


  validarToken(String token) async {
    try {
      
      var response = await client.put(
        "https://sms.comtele.com.br/api/v2/tokenmanager",
        data: {
          "TokenCode": token
        },
        options: Options(
          headers: {
            "auth-key": "e6e85810-046d-4afd-9b3d-e34e883e6c63",
            "content-type": "application/json"
          }
        )
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}