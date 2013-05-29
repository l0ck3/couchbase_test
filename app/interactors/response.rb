class Response < OpenStruct

  def success?
    !errors
  end

end
