module ApplicationHelper

  def group_button_to(url, params={}, &block)
    name = params[:name]
    value = params[:value]
    id = "#{name}_#{value}"

    redirect_to_current = params[:redirect]
    redirect_to_current ||=false
    form_params={}
    form_params[:id]=id
    form_params[:class]= 'hidden'
    form_params[:class]+= ' useajax' if params[:useajax]
    form_params['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    params.except!(:name, :value, :useajax, :delete_parent)
    content = capture(&block)
    params[:form]= id
    render :partial => 'partial/group_button_to', :locals =>
        {:url => url, :content => content, :redirect_to_current => redirect_to_current,
         :form_params => form_params, :name => name, :value => value, :params => params}
  end
end
