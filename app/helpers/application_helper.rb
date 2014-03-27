module ApplicationHelper

  def group_button_to(url, params={}, &block)
    name = params[:name]
    value = params[:value]
    id = "#{name}_#{value}_#{SecureRandom.uuid}"

    redirect_to_path =params[:redirect_to]
    form_params={}
    form_params[:id]=id
    form_params[:class]= 'hidden'
    form_params[:class]+= ' useajax' if params[:useajax]
    form_params['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    params.except!(:name, :value, :useajax, :delete_parent, :redirect_to)
    content = capture(&block)
    params[:form]= id
    render :partial => 'partial/group_button_to', :locals =>
        {:url => url, :content => content,
         :form_params => form_params, :name => name, :value => value, :params => params, :redirect_to_path => redirect_to_path}
  end

  def image_hover_tag(image, link = nil, &block)
    content = capture(&block)
    render :partial => 'partial/image_hover_tag', :locals => {:image => image, :content => content, :link => link}
  end
end
