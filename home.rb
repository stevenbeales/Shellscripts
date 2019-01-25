#!/usr/bin/env ruby

def find_home    # :nodoc:
  ['HOME', 'USERPROFILE'].each do |homekey|
    return ENV[homekey] if ENV[homekey]
  end
  if ENV['HOMEDRIVE'] && ENV['HOMEPATH']
    return "#{ENV['HOMEDRIVE']}:#{ENV['HOMEPATH']}"
  end
  begin
    File.expand_path("~")
  rescue StandardError => ex
    if File::ALT_SEPARATOR
      "C:/"
    else
      "/"
    end
  end
end

if $0 == __FILE__
  puts find_home
end