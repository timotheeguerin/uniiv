module ManytomanyRelationshipHelper

  def get_relation(mparams)
    relation = {}
    relation[:object] = mparams[:model].constantize.find(mparams[:model_id])
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
    render :partial => 'manytomany_relationship/list', :locals => {:relation => relation, :mparams => mparams}
  end
end
