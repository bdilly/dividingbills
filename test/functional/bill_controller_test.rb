require File.dirname(__FILE__) + '/../test_helper'
require 'bill_controller'

# Re-raise errors caught by the controller.
class BillController; def rescue_action(e) raise e end; end

class BillControllerTest < Test::Unit::TestCase
  def setup
    @controller = BillController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
