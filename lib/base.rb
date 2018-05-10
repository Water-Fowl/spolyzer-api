# frozen_string_literal: true

def template(src_file, dist_file)
  if src_file_path = template_file(src_file)
    src_file_string = StringIO.new(ERB.new(File.read(src_file_path)).result(binding))

    random_string = SecureRandom.hex
    upload! src_file_string, "/tmp/#{random_string}"
    execute :sudo, "mv /tmp/#{random_string} #{dist_file}"
    execute :sudo, "rm -f /tmp/#{random_string}"

    info "copying: #{src_file_path} to: #{dist_file}"
  else
    error "error: can't be moved"
  end
end

def template_file(name)
  if File.exist?((file = "lib/templates/#{name}"))
    file
  end
end
