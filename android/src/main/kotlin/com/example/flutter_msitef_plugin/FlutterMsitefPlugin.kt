package com.example.flutter_msitef_plugin

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import android.util.Log

import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter

enum class TipoProcessamento {
  OUTROS,
  CREDITO,
  DEBITO,
  PIX,
  CARTEIRA_DIGITAL,
  ADM,
  CANCELAMENTO
}

enum class TipoParcelamento {
  NENHUM,
  LOJA,
  ADM
}

class FlutterMsitefPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private val REQUEST_CODE_MSITEF = 1234
  private val REQUEST_URL_MSITEF = "br.com.softwareexpress.sitef.msitef.ACTIVITY_CLISITEF"

  override fun onDetachedFromActivity() {
    Log.d("KOTLIN", "onDetachedFromActivity")
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Log.d("KOTLIN", "onReattachedToActivityForConfigChanges")
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Log.d("KOTLIN", "onDetachedFromActivityForConfigChanges")
    activity = null
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    Log.d("KOTLIN", "onDetachedFromEngine")
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_msitef_plugin")
    channel.setMethodCallHandler(this)
    Log.d("KOTLIN", "onAttachedToEngine")
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.d("KOTLIN", "onMethodCall")

    when (call.method) {

      "msitef#getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      
      "msitef#adm" -> handleSitefAdm(call, result)

      "msitef#credito" -> handleSitefCredito(call, result)

      "msitef#debito" -> handleSitefDebito(call, result)

      "msitef#pix" -> handleSitefPix(call, result)

      "msitef#carteiras" -> handleSitefCarteiraDigital(call, result)

      "msitef#cancelamento" -> handleSitefCancelamento(call, result)

      "msitef#outros" -> handleSitefOutros(call, result)

      
    else -> result.notImplemented()
    
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("KOTLIN", "onAttachedToActivity")

    activity = binding.activity
    binding.addActivityResultListener { requestCode, resultCode, data ->
        Log.d("KOTLIN", "onActivityResultListener")
        
        if (requestCode == REQUEST_CODE_MSITEF) {
            when (resultCode) {
                Activity.RESULT_OK -> {
                    Log.d("KOTLIN", "Activity RESULT_OK")
                    val response = mapOf(
                        "STATUS" to "RESULT_OK",                        
                        "CODRESP" to data?.getStringExtra("CODRESP"),
                        "COMP_DADOS_CONF" to data?.getStringExtra("COMP_DADOS_CONF"),
                        "CODTRANS" to data?.getStringExtra("CODTRANS"),
                        "TIPO_PARC" to data?.getStringExtra("TIPO_PARC"),
                        "VLTROCO" to data?.getStringExtra("VLTROCO"),
                        "REDE_AUT" to data?.getStringExtra("REDE_AUT"),
                        "BANDEIRA" to data?.getStringExtra("BANDEIRA"),
                        "NSU_SITEF" to data?.getStringExtra("NSU_SITEF"),
                        "NSU_HOST" to data?.getStringExtra("NSU_HOST"),
                        "COD_AUTORIZACAO" to data?.getStringExtra("COD_AUTORIZACAO"),
                        "NUM_PARC" to data?.getStringExtra("NUM_PARC"),
                        "VIA_ESTABELECIMENTO" to data?.getStringExtra("VIA_ESTABELECIMENTO"),
                        "VIA_CLIENTE" to data?.getStringExtra("VIA_CLIENTE"),
                        "TIPO_CAMPOS" to data?.getStringExtra("TIPO_CAMPOS")
                    )
                    channel.invokeMethod("onMsitefResult", response)
                }
                Activity.RESULT_CANCELED -> {
                    Log.d("KOTLIN", "Activity RESULT_CANCELED")
                    val codResp = data?.getStringExtra("CODRESP")
                    var message: String = "Código de resposta desconhecido"
                    
                    if (codResp != null) {
                      message = getErrorDescription( codResp )
                    }
                    else {
                      message = "msitef: CODRESP inválido"
                    }

                    val response = mapOf(
                      "STATUS" to "RESULT_CANCELED",
                      "CODRESP" to data?.getStringExtra("CODRESP"),
                      "MESSAGE" to message
                    )
                    
                    channel.invokeMethod("onMsitefResult", response)                    
                }
                else -> {
                    Log.d("KOTLIN", "Activity resultCode: $resultCode")
                    
                    val codResp = data?.getStringExtra("CODRESP")
                    var message: String = "Código de resposta desconhecido"
                    
                    if (codResp != null) {
                      message = getErrorDescription( codResp )
                    }
                    else {
                      message = "msitef: CODRESP inválido"
                    }

                    val response = mapOf(
                        "STATUS" to "RESULT_OTHER",
                        "CODRESP" to "-1",
                        "MESSAGE" to message
                      )
                    
                    channel.invokeMethod("onMsitefResult", response)
                }
            }
            true
        } else {
            false
        }
    }
  }

  private fun handleSitefActivity(tipoProcessamento: TipoProcessamento, call: MethodCall, result: Result) {
    Log.d("KOTLIN", "handleSitefActivity")
    val intent =  getIntent(tipoProcessamento, call)
    activity?.startActivityForResult(intent, REQUEST_CODE_MSITEF)
    result.success(null)
  }

  private fun handleSitefAdm(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.ADM, call, result );
  }

  private fun handleSitefCredito(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.CREDITO, call, result );    
  }

  private fun handleSitefDebito(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.DEBITO, call, result );    
  }

  private fun handleSitefPix(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.PIX, call, result );    
  }

  private fun handleSitefCarteiraDigital(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.CARTEIRA_DIGITAL, call, result );    
  }

  private fun handleSitefCancelamento(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.CANCELAMENTO, call, result );    
  }

  private fun handleSitefOutros(call: MethodCall, result: Result) {
    handleSitefActivity( TipoProcessamento.OUTROS, call, result );    
  }
  
  private fun getIntent(tipoProcessamento: TipoProcessamento, call: MethodCall): Intent? {    

    val intent = Intent(REQUEST_URL_MSITEF)
    val otp: String? = call.argument<String>("otp")
    val tokenRegistroTls: String? = call.argument<String>("tokenRegistroTls")
    val tipoPinpad: String? = call.argument<String>("tipoPinpad")

    var tipoParcelamento: TipoParcelamento = TipoParcelamento.NENHUM
    val sTipoParcelamento: String? = (call.argument<String>("tipoParcelamento"))

    if ( !sTipoParcelamento.isNullOrBlank() ){
      try{
        tipoParcelamento = TipoParcelamento.valueOf( sTipoParcelamento )
      }
      catch (e: IllegalArgumentException){
      }
    }
    
    intent.putExtra("empresaSitef", call.argument<String>("empresaSitef"))
    intent.putExtra("enderecoSitef", call.argument<String>("enderecoSitef"))
    intent.putExtra("CNPJ_CPF", call.argument<String>("CNPJ_CPF"))
    intent.putExtra("cnpj_automacao", call.argument<String>("cnpj_automacao"))
    
    intent.putExtra("isDoubleValidation", "0")
    intent.putExtra("caminhoCertificadoCA", "ca_cert_perm")
    intent.putExtra("comExterna", call.argument<String>("comExterna"))
    intent.putExtra("timeoutColeta", call.argument<String>("timeoutColeta"))
    
    if ( !otp.isNullOrBlank() ){
      intent.putExtra("otp", otp)
    }

    if ( !tokenRegistroTls.isNullOrBlank() ){
      intent.putExtra("tokenRegistroTls", tokenRegistroTls)
    }

    if ( !tipoPinpad.isNullOrBlank() ){
      intent.putExtra("tipoPinpad", tipoPinpad)    
    }
           
    if (tipoProcessamento == TipoProcessamento.ADM) {
      Log.d("KOTLIN", "getIntent: ADM")
      intent.putExtra("modalidade", "110");
    }
    else{
      if (tipoProcessamento == TipoProcessamento.CANCELAMENTO) {
        Log.d("KOTLIN", "getIntent: CANCELAMENTO")
        intent.putExtra("modalidade", "200");
      }
      else{
        intent.putExtra("data", getFormatedCurrentDate())
        intent.putExtra("hora", getFormatedCurrentTime())

        intent.putExtra("operador", call.argument<String>("operador"))      
        intent.putExtra("numeroCupom", call.argument<String>("numeroCupom"))      
        intent.putExtra("valor", call.argument<String>("valor"))

        if (tipoProcessamento == TipoProcessamento.OUTROS) { 
          Log.d("KOTLIN", "getIntent: OUTROS")
          intent.putExtra("modalidade", "0")
        }
      
        if (tipoProcessamento == TipoProcessamento.DEBITO) {
          Log.d("KOTLIN", "getIntent: DEBITO")
          intent.putExtra("modalidade", "2")
          intent.putExtra("restricoes", "TransacoesHabilitadas=16")
        }
    
        if (tipoProcessamento == TipoProcessamento.CREDITO) {  
          Log.d("KOTLIN", "getIntent: CREDITO")
          intent.putExtra("modalidade", "3")
          intent.putExtra("numParcelas", call.argument<String>("numParcelas"))
          
          when (tipoParcelamento) {
            TipoParcelamento.NENHUM ->  intent.putExtra("restricoes", "TransacoesHabilitadas=26")
            TipoParcelamento.LOJA -> intent.putExtra("restricoes", "TransacoesHabilitadas=27")
            TipoParcelamento.ADM -> intent.putExtra("restricoes", "TransacoesHabilitadas=28")
            else -> {}
          }
        }
        
        if (tipoProcessamento == TipoProcessamento.PIX) {        
          Log.d("KOTLIN", "getIntent: PIX")
          intent.putExtra("modalidade", "122")
          intent.putExtra("transacoesHabilitadas", "7;8;");
          intent.putExtra("restricoes", "CarteirasDigitaisHabilitadas=027160110024");
        }

        if (tipoProcessamento == TipoProcessamento.CARTEIRA_DIGITAL) {        
          Log.d("KOTLIN", "getIntent: PIX")
          intent.putExtra("modalidade", "0")        
          intent.putExtra("transacoesHabilitadas", "7;8;");
        }
      }
    }

    return intent
  }

  fun getErrorDescription(codResp: String): String {
    return when (codResp.toIntOrNull()) {
        0 -> "Sucesso na execução da função."
        1 -> "Endereço IP inválido ou não resolvido"
        2 -> "Código da loja inválido"
        3 -> "Código de terminal inválido"
        6 -> "Erro na inicialização do Tcp/Ip"
        7 -> "Falta de memória"
        8 -> "Não encontrou a CliSiTef ou ela está com problemas"
        9 -> "Configuração de servidores SiTef foi excedida."
        10 -> "Erro de acesso na pasta CliSiTef (possível falta de permissão para escrita)"
        11 -> "Dados inválidos passados pela automação."
        12 -> "Modo seguro não ativo"
        13 -> "Caminho DLL inválido (o caminho completo das bibliotecas está muito grande)."
        in 14..Int.MAX_VALUE -> "Negada pelo autorizador."
        -1 -> "Módulo não inicializado. O PDV tentou chamar alguma rotina sem antes executar a função configura."
        -2 -> "Operação cancelada pelo operador."
        -3 -> "O parâmetro função / modalidade é inexistente/inválido."
        -4 -> "Falta de memória no PDV."
        -5 -> "Sem comunicação com o SiTef."
        -6 -> "Operação cancelada pelo usuário (no pinpad)."
        -9 -> "A automação chamou a rotina ContinuaFuncaoSiTefInterativo sem antes iniciar uma função iterativa."
        -10 -> "Algum parâmetro obrigatório não foi passado pela automação comercial."
        -12 -> "Erro na execução da rotina iterativa. Provavelmente o processo iterativo anterior não foi executado até o final (enquanto o retorno for igual a 10000)."
        -13 -> "Documento fiscal não encontrado nos registros da CliSiTef. Retornado em funções de consulta tais como ObtemQuantidadeTransaçõesPendentes."
        -15 -> "Operação cancelada pela automação comercial."
        -20 -> "Parâmetro inválido passado para a função."
        -25 -> "Erro no Correspondente Bancário: Deve realizar sangria."
        -30 -> "Erro de acesso ao arquivo. Certifique-se que o usuário que roda a aplicação tem direitos de leitura/escrita."
        -40 -> "Transação negada pelo servidor SiTef."
        -41 -> "Dados inválidos."
        -43 -> "Problema na execução de alguma das rotinas no pinpad."
        -50 -> "Transação não segura."
        -100 -> "Erro interno do módulo."
        in Int.MIN_VALUE..-101 -> "Erros detectados internamente pela rotina."
        else -> "Código de resposta desconhecido."
    }
  }

  fun getFormatedCurrentDate(): String {
    val now = LocalDate.now()

    // Define o formato desejado
    val formatter = DateTimeFormatter.ofPattern("yyyyMMdd")
    // Formata a data usando o formatter
    return now.format(formatter)
  }

  fun getFormatedCurrentTime(): String {
    val now = LocalTime.now()

    // Define o formato desejado
    val formatter = DateTimeFormatter.ofPattern("HHmmss")
    // Formata a data usando o formatter
    return now.format(formatter)
  }


}
