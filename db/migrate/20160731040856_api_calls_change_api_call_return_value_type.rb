class ApiCallsChangeApiCallReturnValueType < ActiveRecord::Migration
  def change
    change_column(:api_calls, :api_call_return_value, :text)
  end
end
