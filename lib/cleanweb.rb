# coding: utf-8
require 'active_support'

class Cleanweb

  require 'net/http'
  require 'rexml/document'
  require 'open-uri'

  class KeyError < StandardError; end
  class NoSubjectError < StandardError; end
  class NoBodyError < StandardError; end

  SPAM_URL = "http://cleanweb-api.yandex.ru/1.0/check-spam"

  class << self
    attr_accessor 'api_key'
  end
  @@api_key = nil

  def self.api_key= key
    @@api_key = key
  end

  def initialize params
    check_key
    @params = params
    check_params
  end

  def check_key
    raise KeyError if @@api_key.nil?
  end

  def check_params
    check_subject
    check_body
  end

  def check_subject
    @subject = @params[:subject]
    raise NoSubjectError if @subject.nil?
  end

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

  def check_body
    @body = @params[:body]
    raise NoBodyError if @body.nil?
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
    puts spam_params
    Net::HTTP.post_form(uri, spam_params).body
  end

end
