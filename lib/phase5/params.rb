require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      query_string = req.query_string.nil? ? "" : req.query_string
      query_params = parse_www_encoded_form(query_string)

    end

    def [](key)
      @params[key.to_sym] || @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }

    def parse_www_encoded_form(www_encoded_form)
      debugger unless www_encoded_form.empty?
      temp_params = URI::decode_www_form(www_encoded_form, enc=Encoding::UTF_8)
      scope = @params
      temp_params.each do |key, value|
        hash_item = parse_key(item) # parse_key of key only

          (0..length-2).each do |i| # iterate over hash_item
            @params << { hash_item[i] => {} }
            # if idx == hash_item.length - 1
            # @params[el] = value
          # else
          # change scope point to current param
          scope[hash_item[i]] ||= {}
          # user[address = {}[street = {}, zip]]
          # user[address[zip]]
          scope = scope[hash_item[i]]

          end
          @params << { key_array[-1] => decoded_form.value }
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split("/\]\[|\[|\]/")
    end
  end
end
