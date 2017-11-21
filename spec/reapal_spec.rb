# coding: utf-8
RSpec.describe Reapal do
  it "设置版本号" do
    expect(Reapal::VERSION).not_to be nil
  end
end
