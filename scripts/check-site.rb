require 'nokogiri'
require 'uri'
require 'cgi'

root = File.expand_path(ARGV[0] || '_site')
base = ARGV[1] || '/JiahuiZhu666'
errors = []
pages = Dir.glob(File.join(root, '**', '*.html'))
documents = {}
pages.each do |path|
  doc = Nokogiri::HTML(File.read(path))
  documents[path] = doc
  ids = doc.css('[id]').map { |node| node['id'] }
  duplicate_ids = ids.group_by { |id| id }.select { |_, matches| matches.length > 1 }.keys
  errors << "#{path}: duplicate IDs #{duplicate_ids.join(', ')}" unless duplicate_ids.empty?
end

documents.each do |path, doc|
  doc.css('[href], [src]').each do |node|
    value = node['href'] || node['src']
    next if value.nil? || value.empty? || value.match?(/\A(?:[a-z]+:|\/\/)/i)
    href, fragment = value.split('#', 2)
    href = URI::DEFAULT_PARSER.unescape(href.split('?', 2).first.to_s)
    target = if href.empty?
      path
    elsif href.start_with?('/')
      if !base.empty? && href != base && !href.start_with?(base + '/')
        errors << "#{path}: link missing base path: #{value}"
      end
      File.join(root, href.sub(/\A#{Regexp.escape(base)}/, '').sub(/\A\//, ''))
    else
      File.expand_path(href, File.dirname(path))
    end
    target = File.join(target, 'index.html') if File.directory?(target)
    unless File.file?(target)
      errors << "#{path}: missing resource #{value}"
      next
    end
    if fragment && !fragment.empty? && documents[target]
      decoded = URI::DEFAULT_PARSER.unescape(fragment)
      errors << "#{path}: missing anchor #{value}" unless documents[target].css('[id]').any? { |el| el['id'] == decoded }
    end
  end
end
home = documents[File.join(root, 'index.html')]
errors << 'Expected exactly three publications' unless home && home.css('.paper-card').length == 3
errors << 'Expected three blog links' unless home && home.css('#blogs .writing-card').length == 3
%w[generative-pre-training.html score-matching.html grpo-kl.html blogs.html my-presentation.html].each do |page|
  errors << "Missing page #{page}" unless documents.key?(File.join(root, page))
end
abort errors.join("\n") unless errors.empty?
puts "Passed: #{pages.length} generated pages; internal links, resources, anchors, unique IDs, publications, and writing routes."
