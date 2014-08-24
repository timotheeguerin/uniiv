require 'github/markdown'
module Utils
  module RichContent
    class Markdown
      def self.to_html(text)
        return GitHub::Markdown.render(text)
      end
    end
  end
end