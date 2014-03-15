module ManytomanyRelationshipHelper

  def get_relation(mparams)
    relation = {}
    relation[:object_class] = mparams[:model].constantize
    relation[:object] = relation[:object_class].find(mparams[:model_id])
    relation[:list] = relation[:object].send(mparams[:relation])
    relation[:relation_class] = relation[:object].class.reflect_on_association(mparams[:relation].to_sym).class_name.constantize
    relation
  end

  def render_manytomany_relationship_list(model, model_id, relation)
    mparams = {}
    mparams[:model] = model.to_s
    mparams[:model_id] = model_id
    mparams[:relation] = relation
    relation = get_relation(mparams)
    render :partial => 'manytomany_relationship/show', :locals => {:relation => relation, :mparams => mparams}
  end

  def render_manytomany_relationship_params(mparams)
  render :partial => 'manytomany_relationship/hidden_params', :locals => {:mparams => mparams}
  end
end
