module SessionsHelper
  def control_group(label, *controls)
    content_tag( :div, {class: 'control-group'}, false ) do
      control_label_tag(label) +
      content_tag( :div, controls.join("\n"), {class: 'controls'}, false )
    end
  end

  def control_label_tag(label = '')
    label_tag( label, nil, class: 'control-label' )
  end
end
