class ProgramSearcher < ApplicationSearcher
  def search
    searcher = self
    search = Program::Program.search do
      init_search(self)
      with :university_id, searcher.filters[:university_id] unless searcher.filters[:university_id].nil?
      with :faculty_id, searcher.filters[:faculty_id] unless searcher.filters[:faculty_id].nil?
    end

    @results = search.results
    self
  end
end