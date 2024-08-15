RSpec.configure do |config|
  config.before(:each, type: :system) do
    # headlessモードをデフォルトに設定
    driven_by(:selenium_chrome_headless)
  end

  config.before(:each, type: :system, js: true) do
    # JavaScriptを使用するテストではheadlessではないchromeを使用する
    driven_by(:selenium_chrome)
  end
end
