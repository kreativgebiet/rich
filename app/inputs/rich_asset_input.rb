class RichAssetInput < ::Formtastic::Inputs::StringInput  
  
  # todo:
  # differentiate between rich_asset and rich_asset_url
  # where the former links an object and the latter returns a url string
  # ?
  
  def input_html_options
    options = super
    options[:class] = [options[:class], "rich_asset"].compact.join(' ')
    options
  end
end