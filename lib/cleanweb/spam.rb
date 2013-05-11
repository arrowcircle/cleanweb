# coding: utf-8

module Cleanweb::Spam
  def parse_xml
    xml = REXML::Document.new(ask_yandex)
    res = []
    begin
      xml.root.elements.each("text") {|e| res << e.attributes["spam-flag"]}
      xml.root.elements.each("links") do |links|
        links.elements.each("link") {|e| res << e.attributes["spam-flag"]}
      end
    rescue
    end
    res.uniq
  end

  def spam?
    results = parse_xml
    if results == ["no"] && !results.empty?
      false
    else
      true
    end
  end

  def spam_params
    res = {key: @@api_key}
    @params.slice([:ip, :email, :name, :login, :realname]).each do |k, v|
      res.merge!(k: v) if @params[k].present?
    end
    res["subject-plain"] = @subject
    res["body-plain"] = @body
    res
  end

  def ask_yandex
    uri = URI.parse(SPAM_URL)
    Net::HTTP.post_form(uri, spam_params).body
  end
end