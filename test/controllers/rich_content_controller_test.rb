require 'test_helper'

class RichContentControllerTest < ActionController::TestCase
  test 'should render markdown' do
    markdown_text = 'Some markdown text'
    get :markdown, text: markdown_text
    assert_response :success
    assert @response.body.include?(markdown_text)
  end
end
