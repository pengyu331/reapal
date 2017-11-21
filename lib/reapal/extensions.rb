module NilClassExtension
  def to_d
    0.to_d
  end
end

NilClass.send(:include, NilClassExtension)
