class UserProgramsController < ApplicationController
  def show
    @programs = current_user.programs
  end

  def new
    @faculty = current_user.faculty
     if @faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t('error.faculty.notselected')
    end
    @options = @faculty.programs.order("type_id ASC, name ASC").to_a
    @options.each do |o|
      if o.type.id == 4
        @options.delete(o)
      end
    end
  end

  def create
    program = params[:prog]
    program = Program.find(params["prog"])
    puts program.nil?
    if program.nil?
      redirect_to user_programs_new_path, :alert => t('error.program.nil')
    elsif current_user.programs.include? program
      redirect_to user_programs_new_path, :alert => t('error.program.taking')
    else
    
      current_user.programs << program
      current_user.save
      redirect_to user_dashboard_index_path
    end
    
  end

  def removeProgram
    program = params["data-service"]
    program = Program.find(program)
    current_user.programs.delete(program)
    
    redirect_to user_dashboard_index_path
  end
end
