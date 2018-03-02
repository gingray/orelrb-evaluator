RSpec.describe Orelrb::Evaluator do
  it "Token exist" do
    expect{Orelrb::Evaluator::Token}.not_to raise_error
  end

  it "simple evaluator" do
    text = "2+2"
    service = Orelrb::Evaluator::Interpreter.new text
    result = service.expr
    expect(result).to eq 4
  end

  it "simple evaluator error" do
    text = "2+ 2"
    service = Orelrb::Evaluator::Interpreter.new text
    expect { service.expr }.to raise_error
  end


end
