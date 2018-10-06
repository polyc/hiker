module SpecTestHelper
  def login
    user = create(:user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper, type: :controller
end
