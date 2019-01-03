class ExampleprofilesController < ApplicationController
  def index
    @profile = Profile.find(1)
    render layout: 'example_layout'
  end
end
