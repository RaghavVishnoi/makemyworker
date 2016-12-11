module ViewSpecHelpers
  def json_body
    JSON.parse(rendered)
  end
end

RSpec.configure do |config|
  config.include ViewSpecHelpers, type: :view
end
