require 'spec_helper'

describe UserMailerWorker do

  describe "perform" do
    it "the worker does some work" do
      worker = UserMailerWorker.new
      worker.perform("abc@example.com", "Abc Xyz")
      expect(ActionMailer::Base.deliveries.length).to eq(1)
    end
  end
end
