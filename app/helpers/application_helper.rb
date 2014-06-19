module ApplicationHelper

  def group_button_to(url, params={}, &block)
    name = params[:name]
    value = params[:value]
    id = SecureRandom.uuid

    redirect_to_path =params[:redirect_to]
    form_params={}
    form_params[:id]=id
    form_params[:class]= 'hidden'
    form_params[:class]+= ' useajax' if params[:useajax]
    form_params['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    form_params[:method] = params[:method]
    params.except!(:name, :value, :useajax, :delete_parent, :redirect_to, :method)
    content = capture(&block)
    params[:form]= id
    render :partial => 'partial/group_button_to', :locals => {
        :url => url, :content => content,
        :form_params => form_params, :name => name, :value => value,
        :params => params, :redirect_to_path => redirect_to_path
    }
  end

  def image_hover_tag(image, link = nil, &block)
    content = capture(&block)
    render :partial => 'partial/image_hover_tag', :locals => {:image => image, :content => content, :link => link}
  end

  def progress_bar_tag(values, options ={})

    types = %w(primary info success warning danger)
    values = if values.is_a? Hash
               values
             else
               hash = {}
               [*values].each_with_index do |value, i|
                 hash[value] = types[i%types.size]
               end
               hash
             end
    render :partial => 'partial/progress_bar_tag', :locals => {:values => values}
  end
end
