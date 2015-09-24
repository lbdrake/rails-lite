require 'json'
require 'webrick'

class Flash < Session
  attr_accessor :flash

  def initialize(req)
    # find cookies and save ivar
    cook = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
    if cook
      @cookie = JSON.parse(cook.value)
    else
      @cookie = {}
    end
    # find flash item in cookies or create new hash
    @cookie[flash] ||= {}
    @flash_now = @cookie[flash]
    @flash_stored = {}
  end

  def flash
    @flash ||= @flash_stored
  end

  def [](key)
    @flash_storage ||= @flash_stored
    @flash_storage[key]
  end

  def []=(key, value)
    @flash_storage ||= @flash_stored
    @flash_storage[key] = value
  end

  def now
    @flash_storage = @flash_now
  end

  def store_flash(res)
    @flash_now = nil
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", JSON.generate(@cookie))
    @flash_stored = nil
  end


end

# check existing cookies for flash
# if there is a flash, use it and delete it

# create a new flash object

# create a method .new - use and delete the flash object in this action

# if we don't call .now - save the flash in cookies for one more action
