# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kinopoisk}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pavel Musolin"]
  s.date = %q{2010-08-02}
  s.description = %q{Easely access the publicly available information on Kinopoisk.ru}
  s.email = %q{pavel@harizma.lv}
  s.extra_rdoc_files = ["README", "lib/extendings.rb", "lib/kinopoisk.rb", "lib/kinopoisk/movie.rb", "lib/kinopoisk/search.rb", "tasks/fixtures.rake"]
  s.files = ["Manifest", "README", "Rakefile", "VERSION", "lib/extendings.rb", "lib/kinopoisk.rb", "lib/kinopoisk/movie.rb", "lib/kinopoisk/search.rb", "spec/fixtures/273302", "spec/fixtures/84991", "spec/fixtures/8880", "spec/fixtures/cover_273302", "spec/fixtures/cover_list_273302", "spec/fixtures/search_tuman_2010", "spec/kinopoisk/kinopoisk_spec.rb", "spec/kinopoisk/movie_spec.rb", "spec/kinopoisk/search_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/fixtures.rake", "kinopoisk.gemspec"]
  s.homepage = %q{http://github.com/pmisters/Kinopoisk}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Kinopoisk", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{kinopoisk}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Easely access the publicly available information on Kinopoisk.ru}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8.1"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.8.1"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.8.1"])
  end
end
