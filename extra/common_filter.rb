class CommonFilter
  attr_reader :props
  def initialize model, params
    @params = arrayed(params)
    @model = model.to_s.capitalize.constantize
    
    @props = Property.
      joins('JOIN values               ON values.property_id = properties.id').
      joins('JOIN property_assignments ON values.id          = property_assignments.value_id').
      where('property_assignments.valueable_type = ?', @model.name).
      group('properties.id').
      preload(:values).
      to_a.group_by(&:slug)
      @props.keys.each{|k| @props[k] = @props[k][0]} 
  end
  
  def path prop, value, kind
    params = unified pars(prop.to_sym, value, kind)
    '?' + URI.unescape(params.to_query)
  end

  def active? prop, value
    @params[prop.to_sym].try{|p| p.include? value}
  end
  
  def checked? prop, value
    active?(prop, value) ? "checked" : "unchecked"
  end


  def models
    cs = @props.keys.map{|key| mult(key, @params[key.to_sym])}.select{|c| c[0]}
    return @model if cs.empty?
    ar = [cs.map{|c| c[0]}.join(" AND ")]
    cs.each{|c| c[1..-1].try(:each){|arg| ar.push arg}}
    @model.where(*ar)
  end

  private
  def mult p, vs
    return [nil] if !vs
    ["(
      SELECT count(*) FROM property_assignments as pa
      JOIN values ON pa.value_id = values.id
      JOIN properties AS p ON p.id = values.property_id
      WHERE pa.valueable_type = '#{@model.name}'
      AND pa.valueable_id = #{@model.table_name}.id
      AND p.slug = ?
      AND values.slug IN (?)
    ) > 0", p, vs]
  end


  def arrayed(params)
    ret = {}
    params.each {|k,v| ret[k.to_sym] = v.class==Array ? v : [v]}
    ret
  end

  def unified(params)
    ret = {}
    params.each {|k,v| vv = params[k]; ret[k] = vv.size==1 ? vv[0] : vv}
    ret
  end

  def toggle(prop, value)
    value = value.to_s
    params = @params.deep_dup
    if active?(prop, value)
      params[prop].delete value
      params.delete(prop) if params[prop].size==0
    else 
      params[prop] = [] if !params[prop]
      params[prop].push value
    end
    params
  end

  def pars(prop, value, kind)
    case kind
    when :toggle
      params = toggle prop, value
      return params
    when :replace
      params = @params.deep_dup
      params[prop] = [value]
      return params
    end
  end
end

