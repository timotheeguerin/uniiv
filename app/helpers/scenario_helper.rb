module ScenarioHelper

  def remove_scenario_from(scenario)
    render 'user/scenario/remove_scenario_form', :scenario => scenario
  end

  def setmain_scenario_form(scenario)
    render 'user/scenario/setmain_scenario', :scenario => scenario
  end

end
