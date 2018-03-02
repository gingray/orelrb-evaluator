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

  it "simple evaluator PLUS" do
    text = "2+ 20"
    service = Orelrb::Evaluator::Interpreter.new text
    result = service.expr
    expect(result).to eq 22
  end

  it "simple evaluator MINUS" do
    text = "2 -20"
    service = Orelrb::Evaluator::Interpreter.new text
    result = service.expr
    expect(result).to eq -18
  end

  it "complex evaluator" do
    text = "2 - 20 + 10"
    service = Orelrb::Evaluator::Interpreter.new text
    result = service.expr
    expect(result).to eq -8
  end

end
