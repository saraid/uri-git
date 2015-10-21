require 'uri'

module URI
  class Git < Generic

    # Only use this method when you're reasonably certain that
    # your string is a Git URI.
    def self.parse(uri)
      repo_name = nil

      # Handle the scp-like syntax for URIs.
      # For more safety, we might have done Regexp parsing.
      # See: http://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a
      parsed_uri = begin
        URI.parse(uri)
      rescue URI::InvalidURIError
        repo_name = uri.split(':').last
        URI.parse(uri[0...uri.rindex(':')])
      end

      # `parsed_uri` should have raised an exception already if nil here.
      # Now we force it into a URI::Git unless something better is available.
      parsed_uri = URI.parse("git://#{parsed_uri}") if parsed_uri.scheme.nil?
      parsed_uri.repo = repo_name unless repo_name.nil?
      parsed_uri
    end

    attr_accessor :repo
  end

  def to_remote_str
    to_s[6..-1] + ":#{repo}"
  end
  @@schemes['GIT'] = Git
end
