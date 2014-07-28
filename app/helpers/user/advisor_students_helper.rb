module User::AdvisorStudentsHelper

  def active_tab?(tab, filter)
    tab == filter ? 'active' : ''
  end
end
