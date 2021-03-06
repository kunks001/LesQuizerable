RSpec::Matchers.define(:have_image) do |src|
  match { |node| node.has_selector? %(img[src="#{src}"]) }

  failure_message_for_should do
    "Expected an image with src #{src.inspect}"
  end

  failure_message_for_should_not do
    "Found image with src #{src.inspect}!"
  end
end
