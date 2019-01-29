module WaitHelper
  def wait(url)
    until current_url === url do
      sleep Capybara.default_max_wait_time
    end
  end
end

Capybara::Session.include WaitHelper
