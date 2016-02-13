Gem::Specification.new do |s|
  s.name        = 'hnjobs'
  s.version     = '0.0.3'
  s.date        = '2016-02-12'
  s.summary     = "HN Jobs API calls wrapper"
  s.description = "API wrapper around the Jobs endpoint of HackerNews"
  s.authors     = ["Hugo Di Francesco"]
  s.email       = 'hugo@awebots.com'
  s.files       = ["lib/hnjobs.rb"]
  s.homepage    =
    'https://github.com/HugoDF/hnjobs'
  s.license       = 'MIT'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
end