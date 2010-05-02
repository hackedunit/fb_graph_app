module Facebook
  class Graph
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'json'

    attr_accessor :form_data, :result_body

    def initialize(call_url, call_type, params = nil, &block)
      self.form_data = Hash.new
      block.call(self)
      self.result_body = JSON.parse(self.run_commands(call_url, call_type, params).body)
    end

    def add_form_data(key, value)
      self.form_data[key] = value
    end

    def run_commands(call_url, call_type, params = nil)
      url = URI.parse("https://graph.facebook.com")
      if call_type == 'post'
        req = Net::HTTP::Post.new("#{url.path}/#{call_url}")
        req.set_form_data(self.form_data)
      else
        req = Net::HTTP::Get.new("#{url.path}/#{call_url}&#{params}")
      end
      h = Net::HTTP.new(url.host, url.port)
      h.use_ssl = true
      return h.start { |http| http.request(req) }
    end

  end
end

