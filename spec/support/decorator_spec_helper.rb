# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

module DecoratorSpecHelper
  def self.included(base)
    base.class_eval do
      before do
        controller = ApplicationController.new
        controller.request = ActionDispatch::TestRequest.create
        ActiveDecorator::ViewContext.push controller.view_context
      end
    end
  end
end
