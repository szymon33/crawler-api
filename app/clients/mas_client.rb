require 'httparty'

class MasClient
  FOUND_DETECTOR = /search-results__heading/
  RESULT_PATTERN = %r{
                     #{FOUND_DETECTOR} # discover if there is any result
                     .*href\s*=\s*"    # find href attribute of the result
                     (?<url>[^"]*)     # assign the url variable without
                                       # trailing spaces and quotes to the url variable
                     "[^>]*            # omit everything else until
                     >                 # closing bracket
                     (?<title>.*)      # then assign the title variable
                     <\/h2             # until end of H2 tag
                     }ix
  WELSH_LANG_URL_PAT = %r{
                         <a\slang="cy"\sclass="t-cy-link" # discover the Welsh language
                                                          # A tag in the html body
                         .*                               # omit everything
                         href\s*=\s*"                     # until href attribute
                         (?<url>.*)"                      # assign the url variable
                         >                                # until closing bracket
                         }ix
  H1_TAG_PATTERN = %r{           # Welsh translation is in the H1 tag
                     <h1.*>      # discover H1 tag assuming that there is only one
                     \s*(.*)\s*  # assign everything what is inside except trailing
                                 # spaces to the first group
                     <\/h1       # until end of H1 tag
                     }ix

  include HTTParty
  base_uri 'https://www.moneyadviceservice.org.uk'

  def initialize(search_str = nil)
    @options = { query: { query: search_str } }
    @english_version_url = nil
    @welsh_version_url = nil
  end

  def build
    resp = self.class.get('/en/search', @options)
    if resp.success? && resp.match(FOUND_DETECTOR)
      english_version(resp).merge(welsh_version)
    else
      {}
    end
  end

  private

  def english_version(search_body_html)
    find = search_body_html.match(RESULT_PATTERN)
    return {} unless find

    # we need to store below url in order to find Welsh version
    @english_version_url = find[:url]

    { en: { title: strip_tags(find[:title]),
            url: "#{self.class.base_uri}#{@english_version_url}" } }
  end

  def welsh_version
    return {} unless welsh_version_url

    response = self.class.get(welsh_version_url)
    return {} unless response.success?

    find = response.match(H1_TAG_PATTERN)
    return {} unless find

    { cy: { title: strip_tags(find[0]),
            url: "#{self.class.base_uri}#{@welsh_version_url}" } }
  end

  def welsh_version_url
    return @welsh_version_url if @welsh_version_url # avoid unnecessary calls

    response = self.class.get(@english_version_url)
    return unless response.success?

    find = response.match(WELSH_LANG_URL_PAT)
    return until find

    @welsh_version_url = find[:url]
  end

  def strip_tags(html)
    ActionView::Base.full_sanitizer.sanitize(html)
  end
end
