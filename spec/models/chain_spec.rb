require 'spec_helper'

describe Chain do
  
  it "should calculate percentages for all its choices" do
    @chain = Chain.create!(
      :anchor => "foo",
      :number => 57
    )
    @chain.choices << Choice.create!(:term => "a", :number => 23)
    @chain.choices << Choice.create!(:term => "b", :number => 4)
    @chain.choices << Choice.create!(:term => "c", :number => 30)
    @chain.update_percentages
    @chain.choices.each do |c|
      c.percent.should > 0
    end
  end
  
end