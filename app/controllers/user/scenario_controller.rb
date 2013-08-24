class User::ScenarioController < ApplicationController
  def new
  end

  def create
    scenario = Course::Scenario.new
    unless params[:scenario_id].nil? #Create a new scenario from an exisitng one
      input_scenario = Course::Scenario.find(params[:scenario_id])
      scenario.taking_courses = input_scenario.taking_courses
    end

    current_user.course_scenarios << scenario
    if current_user.save
      flash[:notice] = t('scenario.create.successF')
      redirect_to user_education_path
    else
      render :new
    end
  end

  def set_current
    scenario = Course::Scenario.find(params[:scenario_id])
    current_scenario = scenario
    flash[:notice] = t('scenario.change.success')
    redirect_to user_education_path
  end

  def remove
    scenario = Course::Scenario.find(params[:scenario_id])

    if scenario.main
      flash[:alert] = t ('scenario.remove.main')
    else
      scenario.destroy
      flash[:notice] = t ('scenario.remove.success')
      redirect_to user_education_path
    end

  end

  def set_main
    scenario = Course::Scenario.find(params[:scenario_id])

    if scenario.main
      flash[:alert] = t ('scenario.setmain.already')
    else
      scenario.main = true
      current_user.main_course_scenario.main = false
      flash[:notice] = t ('scenario.setmain.success')
      redirect_to user_education_path
    end
  end
end
