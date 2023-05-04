Gem::Specification.new do |s|
  s.name        = "kexp-playlist"
  s.version     = "0.0.0"
  s.summary     = "A tool to fetch online radio station KEXP's playlist"
  s.authors     = ["Jason Templeton"]
  s.email       = "jtemple77@gmail.com"
  s.require_paths = ["lib"]
  s.files       = ["bin/kexp-playlist", "lib/kexp-playlist.rb", "lib/kexp/playlist/fetch.rb", "lib/kexp/playlist/presenter.rb"]
  s.bindir      = 'bin'
  s.executables = ['kexp-playlist']
end