require_relative './frecuencia_diaria'
require_relative './frecuencia_semanal'
require_relative './frecuencia_mensual'
require_relative './frecuencia_anual'

class RepositorioFrecuencias
  attr_reader :frecuencias

  def initialize
    @frecuencias = {}
    @frecuencias['diaria'] = FrecuenciaDiaria.new
    @frecuencias['semanal'] = FrecuenciaSemanal.new
    @frecuencias['mensual'] = FrecuenciaMensual.new
    @frecuencias['anual'] = FrecuenciaAnual.new
  end

end