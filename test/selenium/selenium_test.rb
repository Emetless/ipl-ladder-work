require 'json'
require 'selenium-webdriver'
gem 'test-unit'
require 'test/unit'

class Registration < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = 'http://localhost:3000/'
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_1_registration
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:link, 'Sign up').click
    assert !60.times{ break if (element_present?(:link, 'Sign in') rescue false); sleep 1 }
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:id, 'user_password_confirmation').clear
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'Home Page') rescue false); sleep 1 }
  end

  def test_2_wrte_article
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'New Article') rescue false); sleep 1 }
    @driver.find_element(:link, 'New Article').click
    assert !60.times{ break if (element_present?(:id, 'article_content') rescue false); sleep 1 }
    @driver.find_element(:id, 'article_content').clear
    @driver.find_element(:id, 'article_content').send_keys 'Test Article'
    @driver.find_element(:name, 'button').click
    assert !60.times{ break if (element_present?(:css, 'p') rescue false); sleep 1 }
    assert_equal 'Test Article', @driver.find_element(:css, 'p').text
  end

  def test_3_write_comment
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'All Users') rescue false); sleep 1 }
    @driver.find_element(:link, 'All Users').click
    assert !60.times{ break if (@driver.find_element(:xpath, '//div[last()]/div[2]/p').text == 'test@email.com' rescue false); sleep 1 }
    @driver.find_element(:xpath, '(//a[contains(text(),"Articles")])[last()]').click
    assert !60.times{ break if (element_present?(:id, 'comment_content') rescue false); sleep 1 }
    @driver.find_element(:id, 'comment_content').clear
    @driver.find_element(:id, 'comment_content').send_keys 'Test Comment'
    @driver.find_element(:name, 'button').click
    assert !60.times{ break if (element_present?(:xpath, '//div[last()]/div[2]/p[2]') rescue false); sleep 1 }
  end

  def test_4_log_out_and_log_in
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'Leave') rescue false); sleep 1 }
    @driver.find_element(:link, 'Leave').click
    assert !60.times{ break if (element_present?(:id, 'new_user') rescue false); sleep 1 }
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:id, 'comment_content') rescue false); sleep 1 }
  end

  def test_5_delete_article
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'Edit') rescue false); sleep 1 }
    @driver.find_element(:link, 'Edit').click
    assert !60.times{ break if (@driver.find_element(:id, 'article_content').text == 'Test Article' rescue false); sleep 1 }
    @driver.find_element(:link, 'Destroy').click
  end

  def test_6_delete_test_user
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys 'test@email.com'
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys 'password'
    @driver.find_element(:name, 'commit').click
    assert !60.times{ break if (element_present?(:link, 'Info Edit') rescue false); sleep 1}
    @driver.find_element(:link, 'Info Edit').click
    assert !60.times{ break if (element_present?(:link, 'Cancel my account') rescue false); sleep 1 }
    @driver.find_element(:link, 'Cancel my account').click
    @driver.switch_to.alert.accept rescue false
    assert !60.times{ break if (element_present?(:id, 'new_user') rescue false); sleep 1 }
    end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
