module ConfigFactory
  def config(**kwargs)
    instance_double(CaseGrid::Config).tap do |obj|
      allow(obj).to receive_messages **kwargs
    end
  end
end
