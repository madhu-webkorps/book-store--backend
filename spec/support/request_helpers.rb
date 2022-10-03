module RequestHelpers
    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    rescue
      response.body
    end
  end
  
  RSpec.configure do |config|
    config.include RequestHelpers, type: :request
  end